{
  config,
  lib,
  modulesPath,
  username,
  ...
}:

let
  mkBtrfsOpts = subvol: [
    "subvol=@${subvol}"
    "discard"
    "compress=zstd"
  ];
in
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "ahci"
    "thunderbolt"
    "usb_storage"
    "usbhid"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [
    "kvm-amd"
    "f2fs"
  ];
  boot.extraModulePackages = [ ];

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/D36D-6804";
    fsType = "vfat";
    options = [
      "fmask=0137"
      "dmask=0022"
    ];
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/e2c630af-cf1a-4502-91dc-d69145fb8c61";
    fsType = "btrfs";
    options = (mkBtrfsOpts "root") ++ [
      "defaults"
      "ssd"
      "noacl"
      "noatime"
    ];
  };

  fileSystems."/snapshots" = {
    device = "/dev/disk/by-uuid/e2c630af-cf1a-4502-91dc-d69145fb8c61";
    fsType = "btrfs";
    options = [
      "subvol=@snapshots"
      "compress=zstd:6"
      "noexec"
      "nosuid"
      "sync"
      "ssd"
    ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/e2c630af-cf1a-4502-91dc-d69145fb8c61";
    fsType = "btrfs";
    options = (mkBtrfsOpts "home") ++ [
      "defaults"
      "ssd"
      "noacl"
      "noatime"
    ];
  };

  fileSystems."/home/${username}/games" = {
    device = "/dev/disk/by-uuid/bbdffe39-6de4-46f5-85f6-a08f5c77e355";
    fsType = "f2fs";
    options = [
      "defaults"
      # "noauto"
      "nofail"
      "user"
      "ssd"

      "compress_algorithm=zstd"
      "compress_chksum"
      "compress_cache"
      "discard"
      "inline_xattr"
      "extent_cache"
    ];
  };

  swapDevices = [ ];
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp6s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp7s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.amdgpu.initrd.enable = true;
}
