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
    ./zsh.nix
    ./fish.nix
    ./nushell.nix
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

  home.stateVersion = "26.05";
}
