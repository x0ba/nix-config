{ config
, pkgs
, flakePath
, ...
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
    # cargo
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
    rnix-lsp
    selene
    shellcheck
    shfmt
    solc
    sumneko-lua-language-server
    texlab
    nil
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
    source = config.lib.file.mkOutOfStoreSymlink "${flakePath}/home/shared/programs/neovim/config";
    recursive = true;
  };
}
