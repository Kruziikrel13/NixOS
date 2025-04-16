{ config, lib, pkgs, ... }:
with lib;
let cfg = config.opts; in
  {
  options = with types; {
    opts.gaming = {
      enable = mkEnableOption null;
     diskUuid = mkOption {
       type = str;
     };
    };
  };

  config = mkIf cfg.gaming.enable {
    services.libinput.enable = true;
    ## Set the below when using a Keychron keyboard to ensure that steam doesn't think it's a controller.
    ### I used this specifically to fix input bugs with Metal Gear Solid 5
    services.udev.extraRules = ''
      SUBSYSTEM=="input", ATTRS{idVendor}=="3434", ATTRS{idProduct}=="0161", ENV{ID_INPUT_JOYSTICK}="" 
    '';

   fileSystems = {
     ${"/home/" + cfg.Username + "/games"} = {
       device = "/dev/disk/by-uuid/${cfg.gaming.diskUuid}";
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
        ## Currently seems to cause steam logs to spam missing libs
        # extest.enable = true;
      };
      gamemode.enable = true;
    };
    hardware.steam-hardware.enable = true;
  };
}
