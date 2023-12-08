{
  pkgs,
  lib,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) isDarwin;
in {
  programs.firefox = {
    # since I'm using firefox from brew on darwin, I need to build a dummy package
    # to still manage it via home-manager
    enable = true;
    package = pkgs.lib.mkIf isDarwin (pkgs.writeScriptBin "__dummy-firefox" "");
    profiles.default = {
      search = {
        default = "Searxng";
        engines = {
          "Searxng".urls = [{template = " https://se.x0ba.lol/search?q={searchTerms}";}];
        };
        force = true;
      };
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        multi-account-containers
        onepassword-password-manager
        temporary-containers
        ublock-origin
        vimium
      ];

      extraConfig = import ./firefox/userjs.nix;
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
