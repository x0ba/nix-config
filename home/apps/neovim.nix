{
  config,
  pkgs,
  flakePath,
  ...
}: {
  programs.neovim = {
    enable = true;
    withNodeJs = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  home.packages = with pkgs; [
    # Dev tools
    alejandra
    go
    asmfmt
    sccache
    cargo
    black
    delve
    elixir_ls
    rustc
    gawk
    go
    stylua
    gocode-gomod
    gomodifytags
    gopkgs
    gopls
    gotests
    go-outline
    go-tools
    java-language-server
    kotlin-language-server
    ktlint
    lldb
    nodejs
    rust-analyzer
    selene
    nil
    shellcheck
    shfmt
    solc
    marksman
    sumneko-lua-language-server
    texlab
    uncrustify
    nixpkgs-fmt
    zls
    nodePackages.jsonlint
    nodePackages.jsonlint
    nodePackages.node2nix
    nodePackages.prettier
    nodePackages.pyright
    nodePackages.stylelint
    nodePackages.typescript-language-server
    nodePackages.vls
    nodePackages.vscode-langservers-extracted
    nodePackages.yaml-language-server
    nodePackages.yarn
  ];

  xdg.configFile."nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink "${flakePath}/home/apps/nvim";
    recursive = true;
  };
}
