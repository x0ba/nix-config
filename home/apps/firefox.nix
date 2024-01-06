{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (pkgs.stdenv) isLinux;
in {
  config = lib.mkIf config.isGraphical {
    programs.firefox = {
      # since I'm using firefox from brew on darwin, I need to build a dummy package
      # to still manage it via home-manager
      enable = isLinux;
      profiles.default = {
        search = {
          default = "Brave";
          engines = {
            "Brave".urls = [{template = "https://search.brave.com/search?q={searchTerms}";}];
          };
          force = true;
        };
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          multi-account-containers
          bitwarden
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
  };
}
