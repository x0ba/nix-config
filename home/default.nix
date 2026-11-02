{
  lib,
  pkgs,
  user,
  ...
}:
{
  imports = [
    ./lib.nix
    ./aliases.nix
    ./packages.nix
    ./bash.nix
    ./zsh.nix
    ./fish.nix
    ./nushell.nix
    ./starship.nix
    ./git.nix
    ./tools.nix
  ];

  home.username = user;
  home.homeDirectory =
    if pkgs.stdenv.hostPlatform.isDarwin then "/Users/${user}" else "/home/${user}";

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    PAGER = "less";
    LESS = "-g -i -M -R -S -w -X -z-4";
    LANG = "en_US.UTF-8";
  };

  home.sessionPath = [ "$HOME/.local/bin" ];

  # Darwin copies the fonts in home.packages into ~/Library/Fonts; on Linux
  # fontconfig needs to be told about them.
  fonts.fontconfig.enable = pkgs.stdenv.hostPlatform.isLinux;

  home.stateVersion = "26.05";
}
