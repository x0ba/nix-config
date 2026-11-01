{ pkgs, ... }:
{
  home.packages =
    with pkgs;
    [
      fd
      geist-font
      # Ships the "JetBrainsMono Nerd Font Mono" family alongside the
      # proportional and no-ligature variants.
      nerd-fonts.jetbrains-mono
      # Maple Mono's TrueType build, with its programming ligatures.
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
