{ pkgs, user, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  nixpkgs.hostPlatform = "x86_64-linux"; # change to "aarch64-linux" for ARM / VMs on the Mac

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";

  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;
  programs.fish.enable = true;

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };

  system.stateVersion = "26.05";
}
