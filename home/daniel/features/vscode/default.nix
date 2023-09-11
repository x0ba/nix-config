{
  config,
  flakePath,
  lib,
  pkgs,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) isDarwin isLinux;

  settingsJSON = config.lib.file.mkOutOfStoreSymlink "${flakePath}/config/vscode/settings.json";
  keybindingsJSON = config.lib.file.mkOutOfStoreSymlink "${flakePath}/config/vscode/keybindings.json";
in {
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    extensions = with pkgs.vscode-marketplace; [
      decaycs.decay
      monokai.theme-monokai-pro-vscode
      vscjava.vscode-java-pack
      github.copilot
      denoland.vscode-deno
      esbenp.prettier-vscode
      github.vscode-pull-request-github
      jnoortheen.nix-ide
      kamadorueda.alejandra
      leonardssh.vscord
      vscjava.vscode-java-debug
      mkhl.direnv
      pkief.material-icon-theme
      redhat.vscode-yaml
      rust-lang.rust-analyzer
      sumneko.lua
      tamasfe.even-better-toml
      valentjn.vscode-ltex
      vscodevim.vim
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
  xdg.mimeApps.defaultApplications."text/plain" = "codium.desktop";
}
