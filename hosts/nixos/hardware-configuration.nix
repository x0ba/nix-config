# PLACEHOLDER so the flake evaluates.
# On the real machine, replace this file with the output of:
#   nixos-generate-config --show-hardware-config
{ ... }:
{
  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";
    fsType = "vfat";
  };
}
