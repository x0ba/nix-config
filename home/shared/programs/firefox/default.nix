{ lib
, pkgs
, ...
}:
let
  inherit (pkgs.stdenv.hostPlatform) isDarwin isLinux;
in
{
  programs.firefox = {
    enable = true;
    # since I'm using firefox from brew on darwin, I need to build a dummy package
    # to still manage it via home-manager
    package = pkgs.lib.mkIf isDarwin (pkgs.writeScriptBin "__dummy-firefox" "");
    profiles.default = {
      search.default = "DuckDuckGo";
      search.force = true;
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        bitwarden
        clearurls
        decentraleyes
        i-dont-care-about-cookies
        multi-account-containers
        refined-github
        temporary-containers
        ublock-origin
        vimium
      ];
      userChrome = import ./userchrome.nix;
      userContent = import ./usercontent.nix;
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
