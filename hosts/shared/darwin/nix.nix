{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;
  nix = {
    gc.automatic = true;
    package = pkgs.nixVersions.nix_2_16;
    settings = {
      auto-optimise-store = pkgs.stdenv.isLinux;
      substituters = [
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      experimental-features = ["auto-allocate-uids" "flakes" "nix-command" "repl-flake"];
      trusted-users = ["@staff" "@sudo" "@wheel" "daniel"];
      use-xdg-base-directories = true;
      warn-dirty = false;
    };
  };
}
