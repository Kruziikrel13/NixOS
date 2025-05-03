{ globals, lib, pkgs, ... }:
with lib;
{
  config = mkIf globals.gaming.enable {
    services.libinput.enable = true;
    users.users = {
      ${globals.user.name} = {
        extraGroups = [ "gamemode" ];
      };
    };

    # See MGSV.md
    services.udev.extraRules = ''
      SUBSYSTEM=="input", ATTRS{idVendor}=="3434", ATTRS{idProduct}=="0161", ENV{ID_INPUT_JOYSTICK}="" 
    '';

    fileSystems = {
      ${"/home/${globals.user.name}/games"} = {
        options = [ "defaults" "noatime" "nodiratime" "discard" "barrier=1" "nofail" ];
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
