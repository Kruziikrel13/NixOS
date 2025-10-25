{
  lib,
  inputs,
  ...
}:
{
  imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];
  boot = {
    bootspec.enable = true;
    tmp.cleanOnBoot = true;
    loader = {
      timeout = 5;
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        # Force disable when using lanzaboote
        enable = lib.mkForce false;
        editor = false;
        consoleMode = "max";
        configurationLimit = 10;
      };
    };
    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };
  };
}
