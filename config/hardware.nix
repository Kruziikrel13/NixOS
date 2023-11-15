{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.opts;
in {
  imports = [<nixos-hardware/lenovo/thinkpad/l14/amd>];
  config = {
    boot = {
      readOnlyNixStore = true;
      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
        timeout = 5;
      };
      kernelModules = ["nvme" "usb_storage"];
    };

    hardware = {
      opengl.enable = true;
      enableAllFirmware = false;
      cpu.amd = {
        updateMicrocode = true;
        sev.enable = true;
      };
    };

    fileSystems = {
      "/" = {
        options = ["noatime" "ssd" "discard=async" "compress=zstd" "space_cache=v2"];
      };
      "/home" = {
        options = ["noatime" "ssd" "discard=async" "compress=zstd" "space_cache=v2"];
      };
      "/.snapshots" = {
        options = ["noatime" "ssd" "discard=async" "compress=zstd" "space_cache=v2"];
      };
    };

    services.btrfs.autoScrub = {
      enable = true;
      fileSystems = ["/" "/home"];
      interval = "monthly";
    };
  };
}
