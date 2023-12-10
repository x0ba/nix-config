{
  config,
  flakePath,
  pkgs,
  ...
}: let
  mkSymlink = path: config.lib.file.mkOutOfStoreSymlink "${flakePath}/home/apps/fish/${path}";
in {
  programs.fish = {
    enable = true;
    shellAliases = {
      cleanup = "sudo nix-collect-garbage --delete-older-than 7d";
      bloat = "nix path-info -Sh /run/current-system";
      g = "git";
      tree = "${pkgs.lsd}/bin/lsd --tree";
      gaa = "${pkgs.git}/bin/git add .";
      cls = "clear";
      commit = "${pkgs.git}/bin/git add . && ${pkgs.git}/bin/git commit -m";
      m = "mkdir -p";
      cat = "${pkgs.bat}/bin/bat";
      nv = "${pkgs.neovim}/bin/nvim";
      rm = "${pkgs.trash-cli}/bin/trash-put";
    };
    shellInit = ''
      set fish_greeting
      set -U fish_key_bindings fish_vi_key_bindings
      set -Ux EDITOR nvim
      bind -M insert \cf accept-autosuggestion
      function starship_transient_prompt_func
        starship module character
      end
      starship init fish | source
      enable_transience
    '';

    plugins = [
      {
        name = "autopair";
        src = pkgs.fetchFromGitHub {
          owner = "jorgebucaran";
          repo = "autopair.fish";
          rev = "4d1752ff5b39819ab58d7337c69220342e9de0e2";
          sha256 = "qt3t1iKRRNuiLWiVoiAYOu+9E7jsyECyIqZJ/oRIT1A=";
        };
      }
      {
        name = "fzf";
        src = pkgs.fetchFromGitHub {
          owner = "PatrickF1";
          repo = "fzf.fish";
          rev = "8d99f0caa30a626369541f80848ffdbf28e96acc";
          sha256 = "nTiFD8vWjafYE4HNemyoUr+4SgsqN3lIJlNX6IGk+aQ=";
        };
      }
    ];
  };
  xdg.configFile = {
    "fish/themes" = {
      source = mkSymlink "themes";
      recursive = true;
    };
  };
}
