{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    emacs.enable = lib.mkEnableOption "enables emacs";
  };

  config = lib.mkIf config.emacs.enable {
    programs.emacs = {
      enable = true;
      extraPackages = epkgs: [
        epkgs.vterm
        epkgs.mu4e
      ];
      package = pkgs.emacs-macport;
    };
  };
}
