{
  config,
  pkgs,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) isDarwin isLinux;
in {
  programs.vscode = {
    enable = config.isGraphical;
    extensions =
      (with pkgs.vscode-extensions; [
        # patches
        ms-vscode-remote.remote-ssh
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
          nativeBuildInputs = prev.nativeBuildInputs ++ [pkgs.jq pkgs.moreutils];
          postInstall = ''
            cd "$out/$installPrefix"
            jq -e '
              .contributes.configuration.properties."nix.formatterPath".default =
                "${pkgs.alejandra}/bin/alejandra" |
              .contributes.configuration.properties."nix.enableLanguageServer".default =
                "true" |
              .contributes.configuration.properties."nix.serverPath".default =
                "${pkgs.nil}/bin/nil" |
              .contributes.configuration.properties."nix.serverSettings".default.nil.formatting.command[0] =
                "${pkgs.alejandra}/bin/alejandra"
            ' < package.json | sponge package.json
          '';
        }))
        (mads-hartmann.bash-ide-vscode.overrideAttrs (prev: {
          nativeBuildInputs = prev.nativeBuildInputs ++ [pkgs.jq pkgs.moreutils];
          postInstall = ''
            cd "$out/$installPrefix"
            jq -e '
              .contributes.configuration.properties."bashIde.shellcheckPath".default =
                "${pkgs.shellcheck}/bin/shellcheck"
            ' < package.json | sponge package.json
          '';
        }))
        (mkhl.shfmt.overrideAttrs (prev: {
          nativeBuildInputs = prev.nativeBuildInputs ++ [pkgs.jq pkgs.moreutils];
          postInstall = ''
            cd "$out/$installPrefix"
            jq -e '
              .contributes.configuration.properties."shfmt.executablePath".default =
                "${pkgs.shfmt}/bin/shfmt"
            ' < package.json | sponge package.json
          '';
        }))
        adrianwilczynski.alpine-js-intellisense
        ibmlover.oxocarbon
        antfu.icons-carbon
        arcanis.vscode-zipfs
        astro-build.astro-vscode
        bashmish.es6-string-css
        bradlc.vscode-tailwindcss
        catppuccin.catppuccin-vsc-icons
        charliermarsh.ruff
        dbaeumer.vscode-eslint
        denoland.vscode-deno
        dhall.dhall-lang
        dhall.vscode-dhall-lsp-server
        editorconfig.editorconfig
        esbenp.prettier-vscode
        github.copilot
        github.vscode-github-actions
        gitlab.gitlab-workflow
        golang.go
        graphql.vscode-graphql-syntax
        gruntfuggly.todo-tree
        jock.svg
        lunuan.kubernetes-templates
        mikestead.dotenv
        mkhl.direnv
        ms-kubernetes-tools.vscode-kubernetes-tools
        ms-vscode.live-server
        oscarotero.vento-syntax
        pkief.material-icon-theme
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
    mutableExtensionsDir = true;
    userSettings = {
      "workbench.colorTheme" = "oxocarbon";
      "debug.onTaskErrors" = "debugAnyway";
      "diffEditor.ignoreTrimWhitespace" = true;
      "diffEditor.hideUnchangedRegions.enabled" = true;
      "editor.cursorSmoothCaretAnimation" = "on";
      "editor.smoothScrolling" = true;
      "terminal.integrated.smoothScrolling" = true;
      "terminal.integrated.fontSize" = 14;
      "editor.fontFamily" = "SF Mono, Symbols Nerd Font, monospace";
      "editor.fontLigatures" = "'calt', 'liga', 'dlig'";
      "editor.fontSize" = 15;
      "editor.formatOnSave" = true;
      "editor.guides.bracketPairs" = true;
      "editor.inlayHints.enabled" = "onUnlessPressed";
      "editor.inlayHints.fontSize" = 10;
      "editor.inlayHints.padding" = true;
      "editor.inlineSuggest.enabled" = true;
      "editor.lineNumbers" = "relative";
      "editor.minimap.enabled" = false;
      "editor.minimap.renderCharacters" = false;
      "extensions.autoUpdate" = false;
      "extensions.ignoreRecommendations" = true;
      "git.autofetch" = true;
      "git.openRepositoryInParentFolders" = "never";
      "githubPullRequests.pullBranch" = "always";
      "markdown.preview.fontFamily" = "IBM Plex Sans, sans-serif";
      "search.useGlobalIgnoreFiles" = true;
      "search.useParentIgnoreFiles" = true;
      "typescript.inlayHints.parameterNames.enabled" = "all";
      "window.autoDetectColorScheme" = true;
      "window.titleBarStyle" = "custom";
      "workbench.productIconTheme" = "icons-carbon";
      "ltex.additionalRules.enablePickyRules" = true;
      "ltex.additionalRules.motherTongue" = "en-US";
      "ltex.language" = "en-US";
      "redhat.telemetry.enabled" = false;
      "telemetry.telemetryLevel" = "off";
      "workbench.enableExperiments" = false;
      "workbench.settings.enableNaturalLanguageSearch" = false;
      "d.alwaysShowDubStatusButtons" = true;
      "d.servedReleaseChannel" = "beta";
      "d.stdlibPath" = "auto";
      "gopls" = {
        "ui.semanticTokens" = true;
      };
      "[javascript]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[json]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[jsonc]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[less]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[nix]" = {
        "editor.defaultFormatter" = "jnoortheen.nix-ide";
      };
      "[python]" = {
        "editor.defaultFormatter" = "charliermarsh.ruff";
      };
      "[typescript]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[typescriptreact]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "vim.camelCaseMotion.enable" = true;
      "vim.handleKeys" = {
        "<C-a>" = true;
        "<C-d>" = true;
        "<C-u>" = true;
        "<C-v>" = true;
        "<C-w>" = true;
        "<C-x>" = true;
      };
      "vim.highlightedyank.color" = "rgba(128, 128, 128, 0.8)";
      "vim.highlightedyank.enable" = true;
      "vim.hlsearch" = true;
      "vim.incsearch" = true;
      "vim.leader" = "<space>";
      "vim.visualModeKeyBindingsNonRecursive" = [
        {
          "before" = ["r" "h"];
          "commands" = ["git.revertSelectedRanges"];
        }
        {
          "before" = ["<leader>" "y"];
          "commands" = ["editor.action.clipboardCopyAction"];
        }
        {
          "before" = ["<leader>" "p"];
          "commands" = ["editor.action.clipboardPasteAction"];
        }
      ];
      "vim.normalModeKeyBindingsNonRecursive" = [
        {
          "before" = ["g" "r"];
          "commands" = ["editor.action.goToReferences"];
        }
        {
          "before" = ["K"];
          "commands" = ["editor.action.showHover"];
        }
        {
          "before" = ["<leader>" "f" "d"];
          "commands" = ["workbench.action.quickOpen"];
        }
        {
          "before" = ["<leader>" "f" "t"];
          "commands" = ["workbench.action.selectTheme"];
        }
        {
          "before" = ["<leader>" "n" "f"];
          "commands" = ["editor.action.formatDocument"];
        }
        {
          "before" = ["[" "d"];
          "commands" = ["editor.action.marker.prev"];
        }
      ];
      "vim.replaceWithRegister" = true;
      "vim.smartRelativeLine" = true;
    };
    keybindings = [
      {
        "key" = "alt+x";
        "command" = "workbench.action.closeActiveEditor";
        "when" = "editorFocus";
      }
      {
        "key" = "alt+,";
        "command" = "workbench.action.previousEditor";
      }
      {
        "key" = "alt+.";
        "command" = "workbench.action.nextEditor";
      }
      {
        "key" = "shift+cmd+]";
        "command" = "-workbench.action.nextEditor";
        "when" = "editorFocus";
      }
      {
        "key" = "shift+cmd+[";
        "command" = "-workbench.action.previousEditor";
        "when" = "editorFocus";
      }
      {
        "key" = "ctrl+t";
        "command" = "workbench.action.terminal.focus";
        "when" = "editorTextFocus";
      }
      {
        "key" = "ctrl+t";
        "command" = "workbench.action.terminal.toggleTerminal";
        "when" = "terminalFocus";
      }
      {
        "key" = "ctrl+n";
        "command" = "workbench.files.action.focusFilesExplorer";
        "when" = "editorTextFocus";
      }
      {
        "key" = "ctrl+n";
        "command" = "workbench.action.toggleSidebarVisibility";
        "when" = "filesExplorerFocus";
      }
    ];
  };
}
