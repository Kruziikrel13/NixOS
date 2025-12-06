{ lib, config, ... }:
with lib;
mkIf (config.modules.profiles.role == "laptop") {
  services = {
    libinput.enable = true; # Touchpad
    tlp.enable = true;
    thermald.enable = true; # CPU Temp Management
  };
  boot.initrd.availableKernelModules = [
    "xhci_pci" # USB 3.0
    "sdhci_pci" # SD card reader
    "ahci" # USB human interface devices
  ];
}
