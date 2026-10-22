{ lib, pkgs, user, ... }:
{
  imports = [
    ./lib.nix
    ./packages.nix
    ./zsh.nix
    ./fish.nix
    ./git.nix
    ./tools.nix
  ];
  # darwin.nix / linux.nix are added per machine in hosts/default.nix.

  home.username = user;
  home.homeDirectory = if pkgs.stdenv.hostPlatform.isDarwin then "/Users/${user}" else "/home/${user}";

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
