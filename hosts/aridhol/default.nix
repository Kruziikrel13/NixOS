{
  username,
  nixos-hardware,
  lib,
  ...
}:
{

  networking.hostName = "aridhol";
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  networking.useDHCP = lib.mkDefault true;
  imports = [
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
        signingKey = "CC4C1D82D045B5DA";
      };
    };
  };
  boot.initrd.luks.devices."enc".device = "/dev/disk/by-uuid/a95aa5e1-a1e6-47be-b78f-663246bfd078";
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/158c17d8-d90d-443d-ab0d-8ebce12758db";
      fsType = "btrfs";
      options = [ "subvol=root" ];
    };
    "/nix" = {
      device = "/dev/disk/by-uuid/158c17d8-d90d-443d-ab0d-8ebce12758db";
      fsType = "btrfs";
      options = [ "subvol=nix" ];
    };
    "/var/log" = {
      device = "/dev/disk/by-uuid/158c17d8-d90d-443d-ab0d-8ebce12758db";
      fsType = "btrfs";
      options = [ "subvol=log" ];
    };
    "/home" = {
      device = "/dev/disk/by-uuid/158c17d8-d90d-443d-ab0d-8ebce12758db";
      fsType = "btrfs";
      options = [ "subvol=home" ];
    };
    "/persist" = {
      device = "/dev/disk/by-uuid/158c17d8-d90d-443d-ab0d-8ebce12758db";
      fsType = "btrfs";
      options = [ "subvol=persist" ];
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/1F99-8700";
      fsType = "vfat";
    };
  };

  swapDevices = [ ];
}
