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
  discord.enable = true;
  fonts.enable = true;
  emacs.enable = true;
  spicetify.enable = true;
  kitty.enable = true;
}
