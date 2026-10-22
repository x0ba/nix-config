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

      claude-code
      cursor-cli
      opencode
    ]
    ++ lib.optionals stdenv.hostPlatform.isDarwin [ coreutils-prefixed ];
}
