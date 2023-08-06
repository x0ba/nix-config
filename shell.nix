{ pkgs ? import ./nixpkgs.nix { }, self ? { } }:

{
  default = pkgs.mkShell {
    NIX_CONFIG = "experimental-features = nix-command flakes";
    nativeBuildInputs = with pkgs; [ nix home-manager git ];
  };
}
