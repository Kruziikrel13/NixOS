{ config, lib, ... }:

with lib;
let cfg = config.opts.hardware; in
{
  options = {
    opts.hardware = {
      supportLogitechMouse = mkEnableOption false;
    };
  };
  config = {
    services = {
      auto-cpufreq.enable = true;
      fstrim.enable = true;
      gvfs.enable = true;
      ratbagd.enable = cfg.supportLogitechMouse;
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
      logitech = mkIf cfg.supportLogitechMouse {
        wireless.enable = true;
        wireless.enableGraphical = true;
      };
    };
  };
}
