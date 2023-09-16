{
  pkgs,
  lib,
  ...
}: {
  system.activationScripts.postActivation.text = ''
    # Set the default shell as fish for the user. MacOS doesn't do this like nixOS does
    sudo chsh -s ${lib.getBin pkgs.zsh}/bin/zsh daniel
  '';
}
