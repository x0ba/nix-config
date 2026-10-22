{ pkgs, user, ... }:
{
  imports = [
    ../../modules/darwin/homebrew.nix
    ../../modules/darwin/defaults.nix
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";

  networking.hostName = "Daniels-MacBook-Pro";
  networking.localHostName = "Daniels-MacBook-Pro";

  # Determinate Nix manages the Nix installation.
  nix.enable = false;

  system.primaryUser = user;

  users.users.${user} = {
    home = "/Users/${user}";
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;
  programs.fish.enable = true;

  # workaround for rex cli not being in path
  environment.interactiveShellInit = ''
    if [ -n "$REX_BIN_DIR" ]; then
      export PATH="$REX_BIN_DIR:$PATH"
    fi
  '';

  system.stateVersion = 6;
}
