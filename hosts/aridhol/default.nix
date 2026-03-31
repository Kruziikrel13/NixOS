{ self, ... }:
rec {
  imports = [ self.modules.nixos-hardware.lenovo-ideapad-slim-5 ];
  system = "x86_64-linux";
  modules = {
    profiles = {
      user = "kruziikrel13";
      role = "laptop";
      hardware = [
        "cpu/amd"
        "gpu/amd"
        "audio"
        "ssd"
        "wifi"
        "secureboot"
        "bluetooth"
      ];
    };
    desktop = {
      cosmic.enable = true;
      browsers.zen.enable = true;
      apps = {
        protonmail.enable = true;
        element.enable = true;
        grayjay.enable = true;
      };
    };
    editors = {
      default = "nvim";
      helix.enable = true;
    };
    shell = {
      defaultSuite = true;
      gnupg.enable = true;
      nh.enable = true;
      git = {
        enable = true;
        email = "dev@michaelpetersen.io";
        signingKey = "FD6B6BACF0957FF5E5C06BD4741AB4A1DF4006DD";
      };
    };
  };

  config = { pkgs, ... }: { };

  hardware =
    { ... }:
    {
      fileSystems = {
        "/" = {
          device = "/dev/disk/by-label/NIXOS";
          fsType = "btrfs";
        };
        "/home" = {
          device = "/dev/disk/by-label/NIXOS";
          fsType = "btrfs";
        };
        "/boot" = {
          device = "/dev/disk/by-label/BOOT";
          fsType = "vfat";
        };
        "/snapshots" = {
          device = "/dev/disk/by-label/NIXOS";
          fsType = "btrfs";
          options = [
            "subvol=@snapshots"
            "compress=zstd:6"
            "noexec"
            "nosuid"
            "sync"
          ];
        };
      };

      swapDevices = [ ];
    };
}
