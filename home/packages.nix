# CLI tools that were Homebrew formulae (plus a few curl-installed ones that
# nixpkgs packages). Tools with their own Home Manager module are enabled in
# tools.nix instead.
#
# Left out on purpose:
#   - mackup: it symlinks the same dotfiles Home Manager now owns, so the two would fight.
#   - Berkeley Mono: commercial font, installed by hand.
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
    # Homebrew's coreutils installs g-prefixed commands (gls, gdate…), leaving
    # the macOS ones in place. Match that on the Mac; Linux already has GNU tools.
    ++ lib.optionals stdenv.hostPlatform.isDarwin [ coreutils-prefixed ];
}
