{ pkgs ? import ./nixpkgs.nix {}, self ? {}}: {
  default = pkgs.mkShell {
    shellHook = pkgs.lib.mkIf self ? checks self.checks.${pkgs.system}.pre-commit-check.shellHook;
    NIX_CONFIG = "experimental-features = nix-command flakes";
    nativeBuildInputs = with pkgs; [nix home-manager git];
  };
}
