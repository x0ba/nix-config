{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (pkgs.stdenv) isDarwin isLinux;
in {
  home.packages = with pkgs; [
    (discord.override {
      withOpenASAR = true;
    })
  ];
  home.activation.discordSettings = let
    css = ''
      @import url("https://catppuccin.github.io/discord/dist/catppuccin-mocha.theme.css");
      :root {
        --font-primary: "IBM Plex Sans", sans-serif;
        --font-headline: "IBM Plex Sans", sans-serif;
        --font-display: "IBM Plex Sans", sans-serif;
        --font-code: "Monaspace Neon", "Symbols Nerd Font", mono;
      }

    '';
    json = pkgs.writeTextFile {
      name = "discord-settings.json";
      text =
        lib.generators.toJSON {}
        {
          DANGEROUS_ENABLE_DEVTOOLS_ONLY_ENABLE_IF_YOU_KNOW_WHAT_YOURE_DOING = true;
          MIN_WIDTH = 0;
          MIN_HEIGHT = 0;
          openasar = {
            inherit css;
            setup = true;
          };
          trayBalloonShown = false;
          SKIP_HOST_UPDATE = true;
        };
    };
    path =
      if isLinux
      then config.xdg.configHome + "/discord/settings.json"
      else if isDarwin
      then config.home.homeDirectory + "/Library/Application Support/discord/settings.json"
      else throw "unsupported platform";
  in
    lib.hm.dag.entryAfter ["writeBoundary"] ''
      mkdir -p "$(dirname "${path}")"
      cp -f "${json}" "${path}"
    '';
}
