{
  lib,
  pkgs,
  ...
}:
/*
home-manager configuration
Useful links:
- Home Manager Manual: https://nix-community.gitlab.io/home-manager/
- Appendix A. Configuration Options: https://nix-community.gitlab.io/home-manager/options.html
*/
{
  home = {
    packages = lib.attrValues {inherit (pkgs) pfetch;};
  };
}
