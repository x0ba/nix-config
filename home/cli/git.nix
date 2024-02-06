{pkgs, ...}: {
  programs.git = {
    enable = true;
    userName = "x0ba";
    userEmail = "dax@omg.lol";

    delta = {
      enable = true;
      options = {
        line-numbers = true;

        width = 1;
        navigate = false;

        hunk-header-style = "file line-number syntax";
        hunk-header-decoration-style = "bold black";

        file-modified-label = "modified:";

        zero-style = "dim";

        minus-style = "bold red";
        minus-non-emph-style = "dim red";
        minus-emph-style = "bold red";
        minus-empty-line-marker-style = "normal normal";

        plus-style = "green normal bold";
        plus-non-emph-style = "dim green";
        plus-emph-style = "bold green";
        plus-empty-line-marker-style = "normal normal";

        whitespace-error-style = "reverse red";
      };
    };

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
