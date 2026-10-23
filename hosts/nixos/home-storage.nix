# /home is not on the OS disk. It is XFS on a VDO volume on its own
# data partition (GPT PARTLABEL=data):
#
#   /dev/disk/by-partlabel/data
#     -> LVM VG "data"
#     -> VDO pool "home-vpool" (compression on; VDO compresses with LZ4)
#     -> VDO LV "home"
#     -> XFS, mounted at /home
#
# Provision that partition once before booting this config:
#   pvcreate /dev/disk/by-partlabel/data
#   vgcreate data /dev/disk/by-partlabel/data
#   lvcreate --type vdo --name home --vdopool home-vpool \
#     --compression y -l 100%FREE -V <logical-size> data
#   mkfs.xfs -K /dev/data/home
#
# Set <logical-size> larger than the partition (4x is a reasonable start)
# so the filesystem can store more than the raw disk once LZ4 shrinks it.
{ config, lib, ... }:
{
  # dm-vdo plus the LVM build that can activate VDO volumes.
  services.lvm.boot.vdo.enable = true;

  # New VDO volumes inherit compression from here. The algorithm is LZ4.
  environment.etc."lvm/lvm.conf".text = ''
    allocation/vdo_use_compression = 1
  '';

  # Hand freed blocks back to the pool so deleted files stop occupying it.
  services.fstrim.enable = true;

  fileSystems."/home" = {
    device = "/dev/data/home";
    fsType = "xfs";
  };

  # Compression is stored in the pool. Turn it on if the pool exists and
  # something created it with compression disabled.
  systemd.services.home-vdo-compression = {
    description = "Enable LZ4 compression on the home VDO pool";
    after = [ "home.mount" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      set -euo pipefail
      if ${lib.getExe' config.services.lvm.package "lvs"} data/home-vpool >/dev/null 2>&1; then
        ${lib.getExe' config.services.lvm.package "lvchange"} --compression y data/home-vpool
      fi
    '';
  };
}
