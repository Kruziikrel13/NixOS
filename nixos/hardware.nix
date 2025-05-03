{
globals,
lib,
...
}: {
  services = {
    auto-cpufreq.enable = true;
    fstrim.enable = true;
  };

  hardware = {
    enableAllHardware = true;
    enableAllFirmware = true;
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    cpu.amd = {
      updateMicrocode = true;
      sev.enable = true;
    };
  };
  services.ratbagd.enable = globals.hardware.supportLogitechMouse;
  hardware.logitech = lib.mkIf globals.hardware.supportLogitechMouse {
    wireless.enable = true;
    wireless.enableGraphical = true;
  };
}
