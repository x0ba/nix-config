{
  config,
  flakePath,
  lib,
  pkgs,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) isDarwin isLinux;

  settingsJSON = config.lib.file.mkOutOfStoreSymlink "${flakePath}/home/apps/vscode/settings.json";
  keybindingsJSON = config.lib.file.mkOutOfStoreSymlink "${flakePath}/home/apps/vscode/keybindings.json";
in {
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-marketplace; [
      ibmlover.oxocarbon
      astro-build.astro-vscode
      github.copilot
      adrianwilczynski.alpine-js-intellisense
      antfu.icons-carbon
      dbaeumer.vscode-eslint
      denoland.vscode-deno
      esbenp.prettier-vscode
      github.copilot
      github.vscode-pull-request-github
      golang.go
      jnoortheen.nix-ide
      kamadorueda.alejandra
      mikestead.dotenv
      mkhl.direnv
      ms-kubernetes-tools.vscode-kubernetes-tools
      pkief.material-icon-theme
      redhat.vscode-yaml
      rust-lang.rust-analyzer
      ms-vscode-remote.remote-ssh
      ms-vscode-remote.remote-ssh-edit
      ms-vscode.remote-explorer
      sumneko.lua
      ms-azuretools.vscode-docker
      tamasfe.even-better-toml
      tomoki1207.pdf
      unifiedjs.vscode-mdx
      vscodevim.vim
      webfreak.code-d
    ];
    mutableExtensionsDir = true;
  };

  home.file = lib.mkIf isDarwin {
    "Library/Application Support/Code/User/keybindings.json".source = keybindingsJSON;
    "Library/Application Support/Code/User/settings.json".source = settingsJSON;
  };
  xdg.configFile = lib.mkIf isLinux {
    "Code/User/keybindings.json".source = keybindingsJSON;
    "Code/User/settings.json".source = settingsJSON;
  };
  xdg.mimeApps.defaultApplications."text/plain" = "code.desktop";
}
