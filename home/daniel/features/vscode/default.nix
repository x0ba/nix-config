{ config
, flakePath
, lib
, pkgs
, ...
}:
let
  inherit (pkgs.stdenv.hostPlatform) isDarwin isLinux;

  settingsJSON = config.lib.file.mkOutOfStoreSymlink "${flakePath}/config/vscode/settings.json";
  keybindingsJSON = config.lib.file.mkOutOfStoreSymlink "${flakePath}/config/vscode/keybindings.json";
in
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.nix-vscode-extensions.vscode-marketplace; [
      catppuccin.catppuccin-vsc-icons
      denoland.vscode-deno
      esbenp.prettier-vscode
      github.vscode-pull-request-github
      jnoortheen.nix-ide
      kamadorueda.alejandra
      leonardssh.vscord
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
    "Library/Application Support/VSCodium/User/keybindings.json".source = keybindingsJSON;
    "Library/Application Support/VSCodium/User/settings.json".source = settingsJSON;
  };
  xdg.configFile = lib.mkIf isLinux {
    "VSCodium/User/keybindings.json".source = keybindingsJSON;
    "VSCodium/User/settings.json".source = settingsJSON;
  };
  xdg.mimeApps.defaultApplications."text/plain" = "codium.desktop";
}
