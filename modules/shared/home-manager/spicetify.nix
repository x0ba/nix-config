{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
{
  options = {
    spicetify.enable = lib.mkEnableOption "enables spicetify";
  };

  config = lib.mkIf config.spicetify.enable {
    programs.spicetify =
      let
        spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
      in
      {
        enable = true;
        enabledExtensions = with spicePkgs.extensions; [
          keyboardShortcut
          powerBar
          history
          oldSidebar
          hidePodcasts
          shuffle
        ];
        theme = spicePkgs.themes.catppuccin;
        colorScheme = "mocha";
      };
  };
}
