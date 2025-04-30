{ config, lib, pkgs, ... }:
with lib;
let cfg = config.opts.primaryUser; in
  {
  options = with types; {
    opts.gaming = {
      enable = mkEnableOption null;
      diskUuid = mkOption {
        type = str;
        description = ''
          Gaming Drive Disk UUID to mount
        '';
      };
    };
  };

  config = mkIf config.opts.gaming.enable {
    services.libinput.enable = true;
    users.users = {
      ${cfg.username} = {
        extraGroups = [ "gamemode" ];
      };
    };

    # See MGSV.md
    services.udev.extraRules = ''
      SUBSYSTEM=="input", ATTRS{idVendor}=="3434", ATTRS{idProduct}=="0161", ENV{ID_INPUT_JOYSTICK}="" 
    '';

    fileSystems = {
      ${"/home/" + cfg.username + "/games"} = {
        device = "/dev/disk/by-uuid/${config.opts.gaming.diskUuid}";
        fsType = "ext4";
        options = [ "defaults" "noatime" "barrier=1" "nofail" ];
      };
    };

    programs = {
      steam = {
        enable = true;
        gamescopeSession.enable = true;
        protontricks.enable = true;
        extraCompatPackages = [ pkgs.proton-ge-bin ];
        # extest.enable = true; ## Currently seems to cause steam logs to spam missing extest 32bit libs
      };
      gamemode.enable = true;
    };
    hardware.steam-hardware.enable = true;
  };
}
