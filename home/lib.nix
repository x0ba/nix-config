{
  inputs,
  pkgs,
  username,
  isNixOS ? true,
}: rec {
  inherit (pkgs.stdenv) isLinux isDarwin;

  extraSpecialArgs = {
    flakePath =
      if isDarwin
      then "/Users/${username}/.config/flake"
      else "/home/${username}/.config/flake";
    inherit inputs;
  };

  hmStandaloneConfig = {
    home.homeDirectory =
      if isLinux
      then "/home/${username}"
      else if isDarwin
      then "/Users/${username}"
      else throw "Unsupported system";
    home.username = username;
    isGraphical = false;
    targets.genericLinux.enable = isLinux;
    xdg.mime.enable = isLinux;
  };

  modules = with inputs;
    [
      agenix.homeManagerModules.age
      caarlos0-nur.homeManagerModules.default
      nix-colors.homeManagerModules.default
      nix-index-database.hmModules.nix-index
      x0ba-nur.homeManagerModules.default
      ./.
    ]
    ++ pkgs.lib.optionals (!isNixOS) [hmStandaloneConfig];
}
