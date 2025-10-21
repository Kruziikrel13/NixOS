{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
{
  imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];
  boot = {
    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };
    plymouth = {
      enable = false;
      theme = "hexagon_dots_alt";
      themePackages = [
        (pkgs.adi1090x-plymouth-themes.overrideAttrs (old: {
          # Fixes off centering of themes on multiple monitors
          installPhase = old.installPhase + ''
            find $out/share/plymouth/themes/ -name \*.script -exec sed -i 's/Window.GetX()/Window.GetX(0)/g' {} \;
            find $out/share/plymouth/themes/ -name \*.script -exec sed -i 's/Window.GetY()/Window.GetY(0)/g' {} \;
          '';
        }))
      ];
    };
    initrd.systemd.enable = true;
    tmp.cleanOnBoot = true;
    kernelParams = lib.optionals config.boot.plymouth.enable [ "plymouth.use-simpledrm" ];
    loader = {
      timeout = 5;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      systemd-boot = {
        enable = lib.mkForce false;
        editor = false;
        consoleMode = "max";
        configurationLimit = 10;
      };
    };
  };
  # TODO Support CPU Power Here? Or Kernel Specific CPU Power Support in Hosts
}
