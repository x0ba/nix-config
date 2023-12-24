{
  config,
  flakePath,
  pkgs,
  ...
}: let
  symlink = fileName: {recursive ? false}: {
    source = config.lib.file.mkOutOfStoreSymlink "${flakePath}/${fileName}";
    recursive = recursive;
  };
in {
  programs.fish = {
    enable = true;
    shellAbbrs = {
      jqless = "jq -C | less -r";

      g = "git";
      gaa = "git add .";
      commit = "git add . && git commit -m";

      nv = "nvim";
      nm = "neomutt";

      n = "nix";
      nd = "nix develop -c $SHELL";
      ns = "nix shell";
      nsn = "nix shell nixpkgs#";
      nb = "nix build";
      nbn = "nix build nixpkgs#";
      nf = "nix flake";

      nr = "nixos-rebuild --flake .";
      nrs = "nixos-rebuild --flake . switch";
      snr = "sudo nixos-rebuild --flake .";
      snrs = "sudo nixos-rebuild --flake . switch";
      hm = "home-manager --flake .";
      hms = "home-manager --flake . switch";

      mutt = "neomutt";
    };
    shellAliases = {
    };
    shellAliases = {
      tree = "${pkgs.lsd}/bin/lsd --tree";
      cp = "${pkgs.xcp}/bin/xcp";
      cat = "${pkgs.bat}/bin/bat";
      nv = "${pkgs.neovim}/bin/nvim";
      rm = "${pkgs.trash-cli}/bin/trash-put";
      backup = "${pkgs.restic}/bin/restic backup ~/Documents/ ~/Desktop ~/Pictures/ ~/.local/share/gopass";
      # Clear screen and scrollback
      clear = "printf '\\033[2J\\033[3J\\033[1;1H'";
    };
    interactiveShellInit = ''
      bind \ee edit_command_buffer
      bind -M insert \cf accept-autosuggestion

      set fish_greeting

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
      {
        name = "colored-man";
        src = pkgs.fetchFromGitHub {
          owner = "decors";
          repo = "fish-colored-man";
          rev = "1ad8fff696d48c8bf173aa98f9dff39d7916de0e";
          sha256 = "uoZ4eSFbZlsRfISIkJQp24qPUNqxeD0JbRb/gVdRYlA=";
        };
      }
    ];
  };
  xdg.configFile = {
    "fish/themes" = symlink "home/apps/fish/themes" {recursive = true;};
  };
}
