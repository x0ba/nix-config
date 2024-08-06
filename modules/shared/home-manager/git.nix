{ config, lib, ... }:
{

  options = {
    git.enable = lib.mkEnableOption "enables git";
  };

  config = lib.mkIf config.git.enable {
    programs.git = {
      enable = true;
      userName = "x0ba";
      userEmail = "danielxu0307@proton.me";
      signing = {
        signByDefault = true;
        key = "0x660DBDE129F4E1D9";
      };

      lfs.enable = true;

      delta = {
        enable = true;
        catppuccin.enable = true;
      };

      aliases = {
        df = "difftool";
        a = "add";
        p = "push";
        r = "rebase";
        ri = "rebase -i";
        cm = "commit";
        pl = "pull";
        s = "status";
        st = "stash";
        ck = "checkout";
        rl = "reflog";
      };

      ignores = [
        # general
        "*.log"
        ".DS_Store"
        # editors
        "*.swp"
        ".gonvim/"
        ".idea/"
        "ltex.*.txt"
        # nix-specific
        ".direnv/"
        ".envrc"
      ];

      extraConfig = {
        core.fsmonitor = "rs-git-fsmonitor";
        init.defaultBranch = "main";
        push.default = "current";
        push.gpgSign = "if-asked";
        rebase.autosquash = true;
        url = {
          "https://github.com/".insteadOf = "gh:";
          "https://github.com/x0ba/".insteadOf = "x0ba:";
          "https://gitlab.com/".insteadOf = "gl:";
        };
      };
    };
  };

}
