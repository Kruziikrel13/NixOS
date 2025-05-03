{ config, lib, pkgs, ... }:
with lib;
let cfg = config.opts.networking; in
{
  options = with types; {
    opts.networking = {
      hostName = mkOption {
        type = str;
        default = "NixOS";
      };
      ssh.enable = mkEnableOption null;
      bluetooth.enable = mkEnableOption null;
    };
  };

  config = {
    services.sshd.enable = cfg.ssh.enable;
    networking = {
      hostName = cfg.hostName;
      networkmanager.enable = true;
      firewall = {
        enable = true;
        allowPing = false;
      };
    };
    users.users = {
      ${config.opts.primaryUser.username} = {
        extraGroups = [ "networkmanager" "network"];
      };
    };

    hardware.bluetooth = mkIf cfg.bluetooth.enable {
      enable = true;
      powerOnBoot = true;
    };
    services.blueman.enable = cfg.bluetooth.enable;
  };
}
