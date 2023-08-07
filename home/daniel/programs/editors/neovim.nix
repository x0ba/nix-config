{
  config,
  pkgs,
  flakePath,
  ...
}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    withNodeJs = true;
  };

  home.packages = with pkgs; [
    # Dev tools
    alejandra
    asmfmt
    black
    delve
    elixir_ls
    gawk
    go
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
    shellcheck
    shfmt
    solc
    marksman
    sumneko-lua-language-server
    texlab
    rnix-lsp
    uncrustify
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
    source = config.lib.file.mkOutOfStoreSymlink "${flakePath}/config/nvim";
    recursive = true;
  };
}
