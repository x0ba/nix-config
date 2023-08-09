{ lib
, pkgs
, config
, ...
}:
let
  inherit (pkgs.stdenv.hostPlatform) isDarwin;
in
{
  programs.firefox = {
    enable = true;
    # since I'm using firefox from brew on darwin, I need to build a dummy package
    # to still manage it via home-manager
    package = pkgs.lib.mkIf isDarwin (pkgs.writeScriptBin "__dummy-firefox" "");
    profiles.default = {
      search = {
        force = true;
        default = "Searx";
        engines = {
          "Searx" = {
            urls = [{ template = "http://priv.au/search?q={searchTerms}"; }];
            definedAliases = [ "@sx" ];
          };
        };
      };
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        bitwarden
        linkding-extension
        canvasblocker
        multi-account-containers
        temporary-containers
        ublock-origin
        vimium
      ];
      userChrome = import ./userchrome.nix;
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
