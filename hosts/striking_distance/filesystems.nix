{ config, username, ... }: {
  fileSystems =  {
    "${config.users.users.${username}.home}/games" = {
      device = "/dev/disk/by-uuid/4bfedbcc-6059-4ff5-aa86-c5d49ee1a9d0";
      fsType = "ext4";
      options = [ "defaults" "noatime" "barrier=1" "nofail" ];
    };
  };
}
