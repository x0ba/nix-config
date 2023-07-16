{ inputs, config, pkgs, ... }:

{
  programs.wezterm = {
    enable = true;
    package = pkgs.wezterm-git;
    extraConfig = import ./settings.nix { theme = config.colorScheme; };
  };
}
