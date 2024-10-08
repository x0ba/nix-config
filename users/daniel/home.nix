{ pkgs, ... }:
{
  home.packages = with pkgs; [
    coreutils-prefixed
    php
    curl
    fd
    ffmpeg
    gnugrep
    jq
    nil
    lazygit
    pandoc
    pfetch
    pinentry_mac
    ripgrep
  ];

  vscode.enable = true;
  git.enable = true;
  ghostty.enable = true;
  fonts.enable = true;
  emacs.enable = true;
  kitty.enable = true;
  tmux.enable = true;
}
