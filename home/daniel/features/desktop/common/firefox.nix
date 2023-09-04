{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) isDarwin;
  theme = config.colorScheme;
in {
  programs.firefox = {
    enable = true;
    # since I'm using firefox from brew on darwin, I need to build a dummy package
    # to still manage it via home-manager
    package = pkgs.lib.mkIf isDarwin (pkgs.writeScriptBin "__dummy-firefox" "");
    profiles.default = {
      search = {
        default = "Searx Belgium";
        engines = {
          "Searx Belgium".urls = [{template = "https://searx.be/search?q={searchTerms}";}];
        };
        force = true;
      };
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        multi-account-containers
        ublock-origin
        decentraleyes
        onepassword-password-manager
        vimium
      ];
      userChrome = import ./userchrome.nix {
        theme = config.colorScheme;
      };
      userContent = import ./usercontent.nix {
        theme = config.colorScheme;
      };
      extraConfig = import ./userjs.nix;
    };
  };
  xdg.mimeApps.defaultApplications = {
    "text/html" = "firefox.desktop";
    "x-scheme-handler/http" = "firefox.desktop";
    "x-scheme-handler/https" = "firefox.desktop";
    "x-scheme-handler/about" = "firefox.desktop";
    "x-scheme-handler/unknown" = "firefox.desktop";
  };
}
