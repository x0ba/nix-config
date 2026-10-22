{ pkgs, user, ... }:
{
  imports = [
    ../../modules/darwin/homebrew.nix
    ../../modules/darwin/defaults.nix
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";

  networking.hostName = "Daniels-MacBook-Pro";
  networking.localHostName = "Daniels-MacBook-Pro";

  # Determinate Nix manages the Nix install and daemon (flakes are on by
  # default), so nix-darwin must not. Extra Nix settings go in
  # /etc/nix/nix.custom.conf, which Determinate creates.
  nix.enable = false;

  system.primaryUser = user;

  users.users.${user} = {
    home = "/Users/${user}";
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;
  programs.fish.enable = true;

  system.stateVersion = 6;
}
