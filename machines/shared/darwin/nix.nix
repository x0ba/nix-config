{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;
  nix = {
    gc.automatic = true;
    package = pkgs.nixVersions.nix_2_16;
    settings = {
      auto-optimise-store = pkgs.stdenv.isLinux;
      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
        "https://cache.garnix.io"
        "https://x0ba.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
        "x0ba.cachix.org-1:a8ujXsFYp+yjUv9sDb6jwSqqJ5wmD+ojnMcbmAQljPA="
      ];
      experimental-features = ["auto-allocate-uids" "flakes" "nix-command" "repl-flake"];
      trusted-users = ["@staff" "@sudo" "@wheel" "daniel"];
      use-xdg-base-directories = true;
      warn-dirty = false;
    };
  };
}
