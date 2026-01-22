{
  lib,
  config,
  ...
}:
let
  inherit (lib.modules) mkIf;
  inherit (lib) elem;
in
mkIf (config.modules.profiles.role == "laptop") {
  assertions = [
    {
      # Ensure wifi is enabled on laptops
      assertion = elem "wifi" config.modules.profiles.hardware;
      message = "Networking on laptops without wifi is currently unsupported.";
    }
  ];
  boot.initrd.availableKernelModules = [
    "xhci_pci" # USB 3.0
    "ahci" # SATA Devices on modern AHCI Controllers
    "sdhci_pci" # SD Card Reader
  ];
  services = {
    libinput.enable = true; # touchpad
    fwupd.enable = true;
    # power management
    thermald.enable = true;
    power-profiles-daemon.enable = lib.mkForce false;
    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_SCALING_GOVERNOR_ON_AC = "ondemand";
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MAX_PERF_ON_BAT = 50;

        # My laptop is always plugged in wherever I'm willing to use it, so I'll
        # value battery lifespan over runtime. Run `tlp fullcharge` to temporarily
        # force full charge.
        # @see https://linrunner.de/tlp/faq/battery.html#how-to-choose-good-battery-charge-thresholds
        START_CHARGE_THRESH_BAT0 = 40;
        STOP_CHARGE_THRESH_BAT0 = 80;
      };
    };
  };
}
