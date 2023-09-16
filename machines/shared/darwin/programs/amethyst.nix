{...}: {
  services.skhd = {
    enable = true;
    skhdConfig = ''
      lalt - return : open -na "''${HOME}/Applications/Home Manager Apps/Alacritty.app"
    '';
  };
}
