{ pkgs
, config
, ...
}:
let
  inherit (pkgs.stdenv.hostPlatform) isDarwin isLinux;
  theme = config.colorScheme;
in
{
  programs.firefox = {
    enable = true;
    # since I'm using firefox from brew on darwin, I need to build a dummy package
    # to still manage it via home-manager
    package = pkgs.lib.mkIf isDarwin (pkgs.writeScriptBin "__dummy-firefox" "");
    profiles.default = {
      search = {
        default = "Searx Belgium";
        force = true;
        engines = {
          "Ecosia" = {
            urls = [{ template = "https://www.ecosia.org/search?method=index&q={searchTerms}"; }];
            definedAliases = [ "@eco" ];
          };
          "Searx Belgium" = {
            urls = [{ template = "https://searx.be/search?q={searchTerms}"; }];
            definedAliases = [ "@searx" ];
          };
        };
      };
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        bitwarden
        clearurls
        decentraleyes
        i-dont-care-about-cookies
        libredirect
        multi-account-containers
        refined-github
        temporary-containers
        ublock-origin
        vimium
      ];
      settings = import ./userjs.nix;
      userChrome = import ./userchrome.nix {
          theme = config.colorScheme;
      };
      userContent = import ./usercontent.nix {
          theme = config.colorScheme;
      };
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
