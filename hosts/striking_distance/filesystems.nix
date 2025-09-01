{ username, ... }:
{
  fileSystems = {
    "/home/${username}/games" = {
      device = "/dev/disk/by-label/games";
      fsType = "ext4";
      options = [
        "defaults"
        "noatime"
        "barrier=1"
        "nofail"
      ];
    };
  };
}
