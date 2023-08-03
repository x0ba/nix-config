{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    trash-cli
    nixfmt
    shellcheck
    git-lfs
    lutgen
    just
    cargo
    rnix-lsp
    ripgrep
    cmake
    fd
    nil
    deadnix
    stylua
    file
    any-nix-shell
    commitizen
    sumneko-lua-language-server
    git-crypt
    sops
    wireguard-tools
    wireguard-go
    # Extras

    imagemagick
    chafa
    jq
    elinks
    gcc
    glow
    fzf
    exiftool
    sdcv
    sqlite
    statix
    # general apps

    obsidian
    discord
    vscodium
    neovide
    karabiner-elements
    spotify
    iina
  ];
}
