{
  system = "x86_64-linux";

  modules = {
    profiles = {
      role = "laptop";
      user = "kruziikrel13";
      hardware = [
        "cpu/amd"
        "gpu/amd"
        "audio"
        "bluetooth"
        "ssd"
        "wifi"
      ];
    };

    desktop.gnome.enable = true;
  };

  ## Local config
  config =
    { pkgs, ... }:
    {

    };

  hardware =
    { ... }:
    {
      fileSystems = {
        "/boot" = {
          device = "/dev/disk/by-uuid/1F99-8700";
          fsType = "vfat";
        };
        "/" = {
          device = "/dev/disk/by-uuid/158c17d8-d90d-443d-ab0d-8ebce12758db";
          fsType = "btrfs";
        };
        "/home" = {
          device = "/dev/disk/by-uuid/158c17d8-d90d-443d-ab0d-8ebce12758db";
          fsType = "btrfs";
        };
      };
    };
}
