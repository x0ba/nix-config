# PLACEHOLDER so the flake evaluates.
# On the real machine, replace this file with the output of:
#   nixos-generate-config --show-hardware-config
# / and /boot are the OS disk. /home is the data disk, defined in
# home-storage.nix. Drop a generated /home entry if you replace this file.
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
