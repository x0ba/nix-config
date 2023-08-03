# Shell for bootstrapping flake-enabled nix and home-manager
# You can enter it through 'nix develop' or (legacy) 'nix-shell'
{ pkgs ? (import ./nixpkgs.nix) { } }: {
  default = config.pre-commit.devShell.overrideAttrs (old: {
    buildInputs = with pkgs; [ nvd nix-output-monitor ];
  });
}
