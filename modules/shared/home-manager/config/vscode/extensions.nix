{pkgs, ...}: {
  programs.vscode.extensions = with pkgs.vscode-extensions;
    [
      # patches
      ms-python.python
      ms-python.vscode-pylance
      # locked to the latest release
      ms-vscode-remote.remote-ssh
      ms-vscode.hexeditor
      ms-vscode.live-server
      ms-vscode.test-adapter-converter
      sumneko.lua
      # needs a pinned release
      github.vscode-pull-request-github
      # pulling in extra binaries, patched for nix
      valentjn.vscode-ltex
    ]
    ++ (with pkgs.vscode-marketplace-release; [
      eamodio.gitlens
      rust-lang.rust-analyzer
      vadimcn.vscode-lldb
    ])
    ++ (with pkgs.vscode-marketplace; [
      # some default config patching to make these work without needing devShells all the time.
      # other extensions like Go/Rust are only really used with devShells,
      # nix & shell are universal enough for me to want them everywhere.
      (jnoortheen.nix-ide.overrideAttrs (prev: {
        nativeBuildInputs =
          prev.nativeBuildInputs
          ++ [
            pkgs.jq
            pkgs.moreutils
          ];
        postInstall = ''
          cd "$out/$installPrefix"
          jq -e '
          .contributes.configuration.properties."nix.enableLanguageServer".default =
          "true" |
          .contributes.configuration.properties."nix.serverPath".default =
          "${pkgs.nixd}/bin/nixd"
          ' < package.json | sponge package.json
        '';
      }))
      (mads-hartmann.bash-ide-vscode.overrideAttrs (prev: {
        nativeBuildInputs =
          prev.nativeBuildInputs
          ++ [
            pkgs.jq
            pkgs.moreutils
          ];
        postInstall = ''
          cd "$out/$installPrefix"
          jq -e '
          .contributes.configuration.properties."bashIde.shellcheckPath".default =
          "${pkgs.shellcheck}/bin/shellcheck"
          ' < package.json | sponge package.json
        '';
      }))
      (mkhl.shfmt.overrideAttrs (prev: {
        nativeBuildInputs =
          prev.nativeBuildInputs
          ++ [
            pkgs.jq
            pkgs.moreutils
          ];
        postInstall = ''
          cd "$out/$installPrefix"
          jq -e '
          .contributes.configuration.properties."shfmt.executablePath".default =
          "${pkgs.shfmt}/bin/shfmt"
          ' < package.json | sponge package.json
        '';
      }))
      adrianwilczynski.alpine-js-intellisense
      akamud.vscode-theme-onedark
      tomphilbin.gruvbox-themes
      antfu.icons-carbon
      arcanis.vscode-zipfs
      astro-build.astro-vscode
      bashmish.es6-string-css
      enkia.tokyo-night
      bradlc.vscode-tailwindcss
      charliermarsh.ruff
      mustafamohamad.min-tomorrow-theme
      raillyhugo.one-hunter
      dbaeumer.vscode-eslint
      denoland.vscode-deno
      dhall.dhall-lang
      dhall.vscode-dhall-lsp-server
      editorconfig.editorconfig
      esbenp.prettier-vscode
      geequlim.godot-tools
      golang.go
      graphql.vscode-graphql-syntax
      gruntfuggly.todo-tree
      hbenl.vscode-test-explorer
      jock.svg
      leonardssh.vscord
      lunuan.kubernetes-templates
      mikestead.dotenv
      mkhl.direnv
      oscarotero.vento-syntax
      redhat.vscode-yaml
      ryanluker.vscode-coverage-gutters
      serayuzgur.crates
      tamasfe.even-better-toml
      tobermory.es6-string-html
      tomoki1207.pdf
      unifiedjs.vscode-mdx
      usernamehw.errorlens
      vscodevim.vim
      webfreak.code-d
    ]);
}
