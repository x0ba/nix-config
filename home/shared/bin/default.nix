{pkgs, ...}: let
  preview = import ./preview.nix {inherit pkgs;};
  run = import ./run.nix {inherit pkgs;};
  updoot = import ./updoot.nix {inherit pkgs;};
  cl = import ./cl.nix {inherit pkgs;};
  nix-search = import ./nix-search.nix {inherit pkgs;};
  t = import ./t.nix {inherit pkgs;};
in {
  home.packages = with pkgs; [
    preview
    cl
    t
    run
    updoot
    nix-search
  ];
}
