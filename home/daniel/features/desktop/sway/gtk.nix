{
  inputs,
  pkgs,
  config,
  ...
}: {
  gtk = {
    enable = true;
    font.name = "sans-serif";

    gtk3 = {
      extraConfig = {gtk-decoration-layout = "menu:";};

      extraCss = ''
        vte-terminal {
          padding: 20px;
        }
      '';
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    theme = {
      name = "tomorrow-night";
      package = (inputs.nix-colors.lib-contrib {inherit pkgs;}).gtkThemeFromScheme {
        scheme = config.colorScheme;
      };
    };
  };
}
