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
    desktop = {
      gnome.enable = true;
      browser = {
        zen.enable = true;
      };
      apps = {
        grayjay.enable = true;
        element.enable = true;
        proton-mail.enable = true;
      };
    };
    editors = {
      default = "nvim";
      nvim.enable = true;
      helix.enable = true;
    };
    shell = {
      rust-core-utils.enable = true;
      git.enable = true;
      gnupg.enable = true;
      direnv.enable = true;
      bat = {
        enable = true;
        replaceCat = true;
      };
      eza = {
        enable = true;
        replaceLs = true;
      };
      zoxide.enable = true;
    };
  };

  config =
    { ... }:
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
        "/nix" = {
          device = "/dev/disk/by-uuid/158c17d8-d90d-443d-ab0d-8ebce12758db";
          fsType = "btrfs";
          options = [ "subvol=nix" ];
        };
      };
    };
}
