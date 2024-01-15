{...}: {
  programs.fish = {
    enable = true;
    shellAliases = {
      cp = "xcp";
      tree = "lsd --tree";
      cat = "bat";
      vim = "nvim";
      rm = "trash-put";
      code = "codium";
      # switch between yubikeys for the same GPG key
      switch_yubikeys = ''gpg-connect-agent "scd serialno" "learn --force" "/bye"'';
    };
    interactiveShellInit = ''
      set -g fish_greeting ""
    '';
  };
}
