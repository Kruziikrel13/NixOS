{
  config,
  lib,
  modulesPath,
  ...
}:

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
    "amdgpu"
    "f2fs"
  ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/e2c630af-cf1a-4502-91dc-d69145fb8c61";
    fsType = "btrfs";
    options = [
      "subvol=@root"
      "ssd"
      "discard"
      "compress=zstd"
      "noatime"
      "noacl"
    ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/D36D-6804";
    fsType = "vfat";
    options = [
      "fmask=0137"
      "dmask=0022"
    ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/e2c630af-cf1a-4502-91dc-d69145fb8c61";
    fsType = "btrfs";
    options = [
      "subvol=@home"
      "noatime"
      "compress=zstd"
      "discard"
      "ssd"
      "noacl"
    ];
  };

  fileSystems."/var/tmp" = {
    device = "/dev/disk/by-uuid/e2c630af-cf1a-4502-91dc-d69145fb8c61";
    fsType = "btrfs";
    options = [
      "subvol=@tmp"
      "compress=zstd"
    ];
  };

  fileSystems."/var/log" = {
    device = "/dev/disk/by-uuid/e2c630af-cf1a-4502-91dc-d69145fb8c61";
    fsType = "btrfs";
    options = [
      "subvol=@log"
      "compress=zstd"
    ];
  };

  swapDevices = [ ];
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp6s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp7s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
