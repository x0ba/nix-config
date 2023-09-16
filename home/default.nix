{
  config,
  lib,
  outputs,
  inputs,
  pkgs,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) isDarwin isLinux;
in {
  imports = [
  ./apps
  ./langs
  ./xdg.nix
  inputs.nix-colors.homeManagerModule
  inputs.x0ba-nur.homeManagerModules.default
  inputs.caarlos0-nur.homeManagerModules.default
  inputs.nix-index-database.hmModules.nix-index
];

  home = {
    packages = with pkgs; ([
      trash-cli
      catimg
      git-lfs
      just
      nix-your-shell
      ripgrep
      cmake
      fd
      file
      git-crypt
      nur.repos.x0ba.cl
      nur.repos.x0ba.lutgen
      nur.repos.x0ba.preview
      nur.repos.x0ba.updoot
      shellcheck
      imagemagick
      chafa
      jq
      elinks
      glow
      fzf
      luarocks
      exiftool
      sdcv
      sqlite
      statix
      deadnix
      ]);
    sessionVariables = lib.mkIf isDarwin {
      SSH_AUTH_SOCK = "${config.programs.gpg.homedir}/S.gpg-agent.ssh";
    };
    stateVersion = "23.05";
  };

  home.mac-wallpaper = ./wallpapers/oxo.png;

  colorScheme = {
    slug = "oxocarbon";
    name = "Oxocarbon";
    author = "Nyoom Engineering";
    colors = {
      base00 = "161616";
      base01 = "262626";
      base02 = "393939";
      base03 = "525252";
      base04 = "dde1e6";
      base05 = "f2f4f8";
      base06 = "ffffff";
      base07 = "08bdba";
      base08 = "3ddbd9";
      base09 = "78a9ff";
      base0A = "ee5396";
      base0B = "33b1ff";
      base0C = "ff7eb6";
      base0D = "42be65";
      base0E = "be95ff";
      base0F = "82cfff";
    };
  };

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # outputs.overlays.modifications
      # outputs.overlays.additions
      inputs.nur.overlay
      inputs.rust-overlay.overlays.default
      (_final: prev: {
        nur = import inputs.nur {
          nurpkgs = prev;
          pkgs = prev;
          repoOverrides = {
            caarlos0 = inputs.caarlos0-nur.packages.${prev.system};
            nekowinston = inputs.nekowinston-nur.packages.${prev.system};
            x0ba = inputs.x0ba-nur.packages.${prev.system};
          };
        };
        nekowinston-nur = import inputs.nekowinston-nur {inherit (prev) pkgs;};
        x0ba-nur = import inputs.x0ba-nur-nur {inherit (prev) pkgs;};
        caarlos0-nur = import inputs.caarlos0-nur {inherit (prev) pkgs;};
      })
      inputs.x0ba-nur.overlays.default
      inputs.nix-vscode-extensions.overlays.default
    ];

    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  systemd.user.startServices = "sd-switch";

  programs = {
    home-manager.enable = true;
    taskwarrior.enable = true;
    nix-index-database.comma.enable = true;
  };
}
