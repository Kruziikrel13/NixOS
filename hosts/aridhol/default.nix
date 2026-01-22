{
  username,
  nixos-hardware,
  lib,
  modulesPath,
  ...
}:
{

  networking.hostName = "aridhol";
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  networking.useDHCP = lib.mkDefault true;
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    nixos-hardware.nixosModules.lenovo-ideapad-slim-5
  ];
  modules = {
    profiles = {
      user = username;
      role = "laptop";
      hardware = [
        "cpu/amd"
        "gpu/amd"
        "audio"
        "ssd"
        "wifi"
        "bluetooth"
      ];
    };
    desktop = {
      gnome.enable = true;
      browsers.zen.enable = true;
      apps = {
        proton-mail.enable = true;
        element.enable = true;
        # grayjay.enable = true;
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
        # signingKey = "CC4C1D82D045B5DA";
      };
    };
  };
  boot.initrd.luks.devices."enc".device = "/dev/disk/by-uuid/a95aa5e1-a1e6-47be-b78f-663246bfd078";
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
}
