{
  config,
  lib,
  pkgs,
  ...
}: let
  homeRoot =
    if pkgs.stdenv.isDarwin
    then "/Users"
    else if pkgs.stdenv.isLinux
    then "/home"
    else throw "Unsupported OS";
in {
  users.users."${config.dotfiles.username}" =
    {
      home = "${homeRoot}/${config.dotfiles.username}";
      shell = pkgs.fish;
    }
    // (
      if pkgs.stdenv.isLinux
      then {
        isNormalUser = lib.mkIf pkgs.stdenv.isLinux true;
        extraGroups = ["wheel"];
      }
      else {}
    );
}
