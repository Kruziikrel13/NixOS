{ lib, config, ... }:
with lib;
mkIf (config.modules.profiles.role == "workstation") (mkMerge [
  {
    boot = {
      loader = {
        timeout = 5;
        systemd-boot = {
          enable = true;
          configurationLimit = 5;
        };
      };
      initrd.availableKernelModules = [
        "xhci_pci" # USB 3.0
        "usb_storage" # USB mass storage devices
        "usbhid" # USB human interface devices
        "ahci" # SATA devices on modern AHCI controllers
        "sd_mod" # SCSI, SATA, and IDE devices
      ];

      # The default maximum is too low, which starves IO hungry apps.
      kernel.sysctl."fs.inotify.max_user_watches" = 524288;
    };

    powerManagement.cpuFreqGovernor = "performance";

    ## TODO: Add network configuration
  }
])
