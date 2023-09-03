{ lib, pkgs, ... }: {
  imports = [
    ../shared/darwin/default.nix
  ];

  system.activationScripts.postActivation.text = ''
    # Set the default shell as fish for the user. MacOS doesn't do this like nixOS does
    sudo chsh -s ${pkgs.zsh}/bin/zsh daniel
  '';
  networking.computerName = "orion";
  networking.hostName = "orion";
}
