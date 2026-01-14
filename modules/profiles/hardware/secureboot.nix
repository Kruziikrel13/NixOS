{
  lib,
  config,
  pkgs,
  lanzaboote,
  ...
}:
let
  inherit (lib) elem mkForce mkDefault;
  inherit (lib.modules) mkIf;
in
{
  imports = [ lanzaboote.nixosModules.lanzaboote ];

  # NOTE: Don't enable until keys have been setup
  config = mkIf (elem "secureboot" config.modules.profiles.hardware) {
    boot = {
      loader.systemd-boot.enable = mkForce false;
      lanzaboote = {
        # autoGenerateKeys.enable = true;
        # autoEnrollKeys = {
        #   enable = true;
        #   # Automatically reboot to enroll the keys in the firmware
        #   autoReboot = true;
        # };
        enable = mkDefault true;
        pkiBundle = "/var/lib/sbctl";
      };
    };
    environment.systemPackages = [ pkgs.sbctl ];
  };
}
