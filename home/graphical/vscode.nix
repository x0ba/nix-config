{
  config,
  lib,
  pkgs,
  flakePath,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) isDarwin isLinux;

  settingsJSON = config.lib.file.mkOutOfStoreSymlink "${flakePath}/configs/vscode/settings.json";
  keybindingsJSON = config.lib.file.mkOutOfStoreSymlink "${flakePath}/configs/vscode/keybindings.json";
in {
  programs.vscode = {
    enable = config.isGraphical;
    package = pkgs.vscodium;
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
        (pkgs.catppuccin-vsc.override {
          accent = "blue";
          colorOverrides = {
            macchiato = {
              text = "#c5c8c9";
              base = "#131a1c";
              mantle = "#192022";
              crust = "#202729";
              surface0 = "#202729";
              surface1 = "#363d3e";
              surface2 = "#4a5051";
            };
          };
          customUIColors = {};
        })
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
  };
  home.file = lib.mkIf isDarwin {
    "Library/Application Support/VSCodium/User/keybindings.json".source = keybindingsJSON;
    "Library/Application Support/VSCodium/User/settings.json".source = settingsJSON;
  };
  xdg.configFile = lib.mkIf isLinux {
    "VSCodium/User/keybindings.json".source = keybindingsJSON;
    "VSCodium/User/settings.json".source = settingsJSON;
  };
  xdg.mimeApps.defaultApplications."text/plain" = "codium.desktop";
}
