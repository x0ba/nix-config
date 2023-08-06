# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example' or (legacy) 'nix-build -A example'
{ pkgs ? (import ../nixpkgs.nix) { } }: {
  # example = pkgs.callPackage ./example { };
  alacritty-ligatures = pkgs.callPackage ./alacritty-ligatures { };
  lutgen = pkgs.callPackage ./lutgen { };
  preview = pkgs.callPackage ./preview { };
  cl = pkgs.callPackage ./cl { };
  updoot = pkgs.callPackage ./updoot { };
  nix-search = pkgs.callPackage ./nix-search { };
  tidal-dl = pkgs.callPackage ./tidal-dl { };
  nix-inspect = pkgs.callPackage ./nix-inspect { };
}
