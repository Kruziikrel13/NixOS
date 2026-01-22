{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) elem;
  inherit (lib.modules) mkIf;
in
{

  config = mkIf (elem "bluetooth" config.modules.profiles.hardware) {
    user.packages = [ pkgs.overskride ];
    hardware.bluetooth = {
      enable = true;
      settings = {
        General = {
          ControllerMode = "bredr";
          Policy.ReconnectAttempts = 0;
          Experimental = true;
          KernelExperimental = true;
        };
      };
    };

    # Brute force a reset after waking up from sleep, as some bluetooth devices
    # will fail to connect to a system that's been suspended at some point.
    powerManagement.resumeCommands = ''
      ${pkgs.util-linux}/bin/rfkill block bluetooth
      ${pkgs.util-linux}/bin/rfkill unblock bluetooth
    '';
  };
}
