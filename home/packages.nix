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
      tree
      watch
      uv
      nodejs_26

      claude-code
      cursor-cli
      opencode
    ]
    ++ lib.optionals stdenv.hostPlatform.isDarwin [ coreutils-prefixed ];
}
