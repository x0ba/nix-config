{
  config,
  pkgs,
  lib,
  ...
}: let
  preview = import ./preview.nix {inherit pkgs;};
  run = import ./run.nix {inherit pkgs;};
  updoot = import ./updoot.nix {inherit pkgs;};
  nix-search = import ./nix-search.nix {inherit pkgs;};
in {
  home.packages = with pkgs; [
    preview
    run
    updoot
    nix-search
  ];
}
