{pkgs, ...}: {
  programs.fish = {
    enable = true;
    shellAliases = {
      cp = "${pkgs.xcp}/bin/xcp";
      tree = "${pkgs.lsd}/bin/lsd --tree";
      cat = "${pkgs.bat}/bin/bat --theme='catppuccin-frappe'";
      vim = "nvim";
      rm = "${pkgs.trash-cli}/bin/trash-put";
      run = "${pkgs.comma}/bin/,";
      git = "${pkgs.git}/bin/git";
      # switch between yubikeys for the same GPG key
      switch_yubikeys = ''gpg-connect-agent "scd serialno" "learn --force" "/bye"'';
    };
    interactiveShellInit = ''
      set -g fish_greeting ""
    '';
  };
}
