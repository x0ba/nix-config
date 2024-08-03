{ pkgs, ... }:
{
  programs.vscode.extensions =
    (with pkgs.vscode-extensions; [
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
    ])
    # pinned releases; these install the latest rather than the nightly version
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
        nativeBuildInputs = prev.nativeBuildInputs ++ [
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
        nativeBuildInputs = prev.nativeBuildInputs ++ [
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
        nativeBuildInputs = prev.nativeBuildInputs ++ [
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
      antfu.icons-carbon
      beardedbear.beardedicons
      (pkgs.catppuccin-vsc.override {
        accent = "rosewater";
        boldKeywords = true;
        italicComments = true;
        italicKeywords = true;
        extraBordersEnabled = false;
        workbenchMode = "default";
        bracketMode = "rainbow";
        colorOverrides = { };
        customUIColors = { };
      })
      arcanis.vscode-zipfs
      astro-build.astro-vscode
      bashmish.es6-string-css
      biomejs.biome
      bradlc.vscode-tailwindcss
      charliermarsh.ruff
      dbaeumer.vscode-eslint
      editorconfig.editorconfig
      esbenp.prettier-vscode
      zhuangtongfa.material-theme
      github.vscode-github-actions
      haskell.haskell
      justusadam.language-haskell
      golang.go
      graphql.vscode-graphql-syntax
      gruntfuggly.todo-tree
      hbenl.vscode-test-explorer
      jock.svg
      mikestead.dotenv
      mkhl.direnv
      redhat.vscode-yaml
      ryanluker.vscode-coverage-gutters
      serayuzgur.crates
      tamasfe.even-better-toml
      tobermory.es6-string-html
      tomoki1207.pdf
      unifiedjs.vscode-mdx
      usernamehw.errorlens
      vscodevim.vim
    ]);
}
