{
  lib,
  config,
  pkgs,
  lanzaboote,
  ...
}:
with lib;
mkIf (elem "secureboot" config.modules.profiles.hardware) {
  imports = [ lanzaboote.nixosModules.lanzaboote ];
  boot = {
    loader.systemd-boot.enable = mkForce false;
    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };
  };
  environment.systemPackages = [ pkgs.sbctl ];
}
