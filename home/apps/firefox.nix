{pkgs, ...}: let
  inherit (pkgs.stdenv.hostPlatform) isLinux;
in {
  programs.firefox = {
    enable = isLinux;
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
        clearurls
        languagetool
        onepassword-password-manager
        darkreader
        refined-github
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
