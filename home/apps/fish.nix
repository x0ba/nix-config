{pkgs, ...}: {
  programs.fish = {
    enable = true;
    shellAliases = {
      cleanup = "sudo nix-collect-garbage --delete-older-than 7d";
      bloat = "nix path-info -Sh /run/current-system";
      g = "git";
      tree = "${pkgs.eza}/bin/eza --tree";
      gaa = "${pkgs.git}/bin/git add .";
      cls = "clear";
      commit = "${pkgs.git}/bin/git add . && ${pkgs.git}/bin/git commit -m";
      m = "mkdir -p";
      cat = "${pkgs.bat}/bin/bat";
      nv = "${pkgs.neovim}/bin/nvim";
      fcd = "cd $(find -type d | fzf)";
      rm = "${pkgs.trash-cli}/bin/trash-put";
    };
    shellInit = ''
      set fish_greeting
      function starship_transient_prompt_func
        starship module character
      end
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
}
