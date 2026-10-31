{ pkgs, ... }:
{
  home.packages =
    with pkgs;
    [
      fd
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
