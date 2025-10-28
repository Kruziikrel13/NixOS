{ username, pkgs, ... }:
{
  environment.systemPackages = [ pkgs.f2fs-tools ];
  # sudo mkfs.f2fs /dev/nvme0n1p1 -l GAMES -t 1 -o 1 -w 4096 -f -O extra_attr,compression,encrypt,sb_checksum,inode_checksum,quota
  # casefold option not supported
  fileSystems = {
    "/home/${username}/games" = {
      device = "/dev/disk/by-uuid/bbdffe39-6de4-46f5-85f6-a08f5c77e355";
      fsType = "f2fs";
      options = [
        "defaults"
        "noatime"
        "nofail"
        "rw"
        "async"
        "exec"
        "compress_algorithm=zstd"
        "compress_chksum"
        "compress_cache"
        "nobarrier"
        "fsync_mode=nobarrier"
        "discard"
        "inline_xattr"
        "extent_cache"
      ];
    };
  };
}
