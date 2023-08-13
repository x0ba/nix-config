{
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
    # signing = {
    #   signByDefault = true;
    #   key = "E8325E515382CDE43B9FBE12DDC4DDB3D659ED62";
    # };
    diff-so-fancy.enable = true;
    aliases = {
      # get plain text diffs for patches
      patch = "!git --no-pager diff --no-color";
      # zip the current repo
      gzip = "!git archive --format=tar.gz --output=$(basename $(git rev-parse --show-toplevel)).tar.gz $(git rev-parse --short HEAD)";
      zip = "!git archive --format=zip --output=$(basename $(git rev-parse --show-toplevel)).zip $(git rev-parse --short HEAD)";
      # for those 3am commits
      yolo = "!git commit -m \"chore: $(curl -s https://whatthecommit.com/index.txt)\"";
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
        "https://github.com/mkshift/".insteadOf = "shift:";
        "https://gitlab.com/".insteadOf = "gl:";
      };
    };
    lfs.enable = true;
    enable = true;
    userName = "x0ba";
    userEmail = "x0ba@proton.me";
  };
}
