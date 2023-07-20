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

    extraPackages = with pkgs; [
      # python
      black
      isort
      nodePackages.pyright

      # nix
      rnix-lsp
      nodejs

      # formatters
      ktlint
      nixpkgs-fmt
      rustfmt
      shfmt

      # lua
      stylua
      lua-language-server
      luaPackages.tl
      luaPackages.teal-language-server

      # data
      taplo

      # go
      go

      # webdev
      nodePackages."@astrojs/language-server"
      nodePackages."@tailwindcss/language-server"
      nodePackages.alex
      nodePackages.bash-language-server
      nodePackages.dockerfile-language-server-nodejs
      nodePackages.graphql
      nodePackages.graphql-language-service-cli
      nodePackages.intelephense
      nodePackages.typescript-language-server
      nodePackages.vscode-langservers-extracted
      nodePackages.yaml-language-server
      yarn

      # rust
      cargo
      rust-analyzer
      rustc
      rustfmt

      # etc
      alejandra
      deno
      ltex-ls
      nil
      nodePackages.prettier
      proselint
      shellcheck
      shfmt
      tree-sitter

      # nvim-spectre
      gnused
      (writeShellScriptBin "gsed" "exec ${gnused}/bin/sed")

      # needed for some plugin build steps
      gnumake
      unzip
    ];
  };

  xdg.configFile."nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink "${flakePath}/config/nvim";
    recursive = true;
  };
}
