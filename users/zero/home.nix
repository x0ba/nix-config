{ lib, pkgs, ... }:
{
  home = {
    packages = lib.attrValues { inherit (pkgs) pfetch; };
  };
}
