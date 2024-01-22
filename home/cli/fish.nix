{...}: {
  programs.fish = {
    enable = true;
    shellAliases = {
      # switch between yubikeys for the same GPG key
      switch_yubikeys = ''gpg-connect-agent "scd serialno" "learn --force" "/bye"'';
      # git aliases
      gaa = "git add -A";
      gst = "git status";
      gd = "git diff";
      gp = "git push";
      gcl = "git clone";
      gco = "git checkout";
      gc = "git commit -m";
      vim = "nvim";
      # general aliases
      cp = "xcp";
      tree = "lsd --tree";
      cat = "bat";
      rm = "trash-put";
      code = "codium";
      neovide = "/Applications/Neovide.app/Contents/MacOS/neovide --frame none";
      emacs_reload = "launchctl unload -w ~/Library/LaunchAgents/org.nixos.emacs.plist && launchctl load -w ~/Library/LaunchAgents/org.nixos.emacs.plist";
    };
    interactiveShellInit = ''
      set -x EDITOR "nvim"
      set -g fish_greeting ""
      set -x PATH ~/.config/emacs/bin $PATH
    '';
  };
}
