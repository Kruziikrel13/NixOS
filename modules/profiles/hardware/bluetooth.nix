{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
mkIf (elem "bluetooth" config.modules.profiles.hardware) {
  hardware.bluetooth.enable = true;
  hardware.bluetooth.settings = {
    General = {
      ControllerMode = "bredr";
      Experimental = true;
      KernelExperimental = true;
    };
    Policy.ReconnectAttempts = 0;
  };

  environemnt.systemPackages = [ pkgs.overskride ];

  # Brute force a reset after waking up from sleep, as some bluetooth devices
  # will fail to connect to a system that's been suspended at some point.
  powerManagement.resumeCommands = ''
    ${pkgs.util-linux}/bin/rfkill block bluetooth
    ${pkgs.util-linux}/bin/rfkill unblock bluetooth
  '';
}
