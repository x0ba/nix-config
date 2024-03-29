{pkgs, ...}: {
  # use fsmonitor
  home.packages = [pkgs.rs-git-fsmonitor pkgs.watchman];
  programs.git = {
    enable = true;
    userName = "x0ba";
    userEmail = "dax@omg.lol";

    delta = {enable = true;};

    signing = {
      signByDefault = true;
      key = "242CE11D4552BFD795AF94286CB88DB2D39E0378";
    };

    aliases = {
      # get plain text diffs for patches
      patch = "!git --no-pager diff --no-color";
      # zip the current repo
      gzip = "!git archive --format=tar.gz --output=$(basename $(git rev-parse --show-toplevel)).tar.gz $(git rev-parse --short HEAD)";
      zip = "!git archive --format=zip --output=$(basename $(git rev-parse --show-toplevel)).zip $(git rev-parse --short HEAD)";
      # for those 3am commits
      yolo = ''
        !git commit -m "chore: $(curl -s https://whatthecommit.com/index.txt)"'';
    };

    lfs.enable = true;

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
      ".envrc"
    ];

    extraConfig = {
      credential.helper = "gopass";
      init.defaultBranch = "main";
      push.default = "current";
      core.fsmonitor = "rs-git-fsmonitor";
      push.gpgSign = "if-asked";
      rebase.autosquash = true;
      url = {
        "https://github.com/".insteadOf = "gh:";
        "https://github.com/x0ba/".insteadOf = "x0ba:";
        "https://gitlab.com/".insteadOf = "gl:";
      };
    };
  };
}
