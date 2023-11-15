{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.opts.System;
in {
  options = {
    opts = {
      System = {
        Hostname = mkOption {
          type = types.str;
          default = "NixOS";
        };
        Modules = {
          EnableBluetooth = mkEnableOption null;
        };
      };
    };
  };

  config = {
    networking = {
      hostName = cfg.Hostname;
      networkmanager.enable = true;
      firewall = {
        enable = true;
        allowPing = false;
      };
    };
    services.sshd.enable = true;
    users.users = {
      ${cfg.Username} = {
        extraGroups = ["networkmanager" "network"];
      };
    };

    hardware.bluetooth = mkIf cfg.Modules.EnableBluetooth {
      enable = true;
      powerOnBoot = true;
      settings.General.ControllerMode = "bredr";
    };
    services.blueman.enable = cfg.Modules.EnableBluetooth;
  };
}
