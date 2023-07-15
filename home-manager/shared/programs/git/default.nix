{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.gh = {
    enable = true;

    extensions = lib.attrValues {
      inherit
        (pkgs)
        gh-cal
        gh-dash
        gh-eco
        ;
    };

    settings = {
      git_protocol = "ssh";
      prompt = "enabled";
      editor = "${pkgs.neovim}/bin/nvim";
    };
  };

  programs.git = {
    signing = {
      signByDefault = true;
      key = "E8325E515382CDE43B9FBE12DDC4DDB3D659ED62";
    };
    ignores = [
      # general
      "*.log"
      ".DS_Store"
      # editors
      "*.swp"
      ".gonvim/"
      ".idea/"
      "ltex.dictionary*.txt"
      # nix-specific
      ".direnv/"
    ];
    extraConfig = {
      init.defaultBranch = "main";
      push.default = "current";
      push.gpgSign = "if-asked";
      rebase.autosquash = true;
      url = {
        "https://github.com/".insteadOf = "gh:";
        "https://github.com/nekowinston/".insteadOf = "aspect:";
        "https://gitlab.com/".insteadOf = "gl:";
      };
    };
    lfs.enable = true;
    enable = true;
    userName = "Daniel Xu";
    userEmail = "heavydenial@proton.me";
  };
}
