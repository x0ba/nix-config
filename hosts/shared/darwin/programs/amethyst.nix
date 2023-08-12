{ pkgs, ... }: {
  services.skhd = {
    enable = true;
    package = pkgs.skhd;
    skhdConfig = ''
      lalt - return : open -na "''${HOME}/Applications/Home Manager Apps/WezTerm.app"
    '';
  };
}
