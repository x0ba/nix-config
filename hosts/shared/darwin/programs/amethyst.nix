{pkgs, ...}: {
  services.skhd = {
    enable = true;
    skhdConfig = ''
      # lalt - return : open -na "''${HOME}/Applications/Home Manager Apps/WezTerm.app"
      lalt - return : ''${HOME}/.nix-profile/bin/wezterm-gui start
    '';
  };
}
