{pkgs, ...}: {
  imports = [./hardware.nix];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = ["quiet" "splash"];
  };

  hardware = {
    bluetooth.enable = true;
  };

  networking = {
    hostName = "polaris";
    networkmanager.enable = true;
    firewall.enable = true;
  };

  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";

  services = {
    openssh.enable = true;
    pcscd.enable = true;
  };

  virtualisation.podman.enable = true;
}
