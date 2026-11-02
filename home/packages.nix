{ pkgs, ... }:
{
  home.packages =
    with pkgs;
    [
      fd
      geist-font
      nerd-fonts.jetbrains-mono
      maple-mono.truetype
      htop
      hunk
      qpdf
      ripgrep
      lazygit
      tree
      watch
      uv
      nodejs_26
    ]
    ++ lib.optionals stdenv.hostPlatform.isDarwin [ coreutils-prefixed ];
}
