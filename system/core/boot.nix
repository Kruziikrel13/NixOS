{
  pkgs,
  lib,
  config,
  ...
}: {
  boot = {
    plymouth = {
      enable = true;
      theme = "hexagon_dots_alt";
      themePackages = [
        (pkgs.adi1090x-plymouth-themes.overrideAttrs (old: {
          installPhase =
            old.installPhase
            + ''
              find $out/share/plymouth/themes/ -name \*.script -exec sed -i 's/Window.GetX()/Window.GetX(0)/g' {} \;
              find $out/share/plymouth/themes/ -name \*.script -exec sed -i 's/Window.GetY()/Window.GetY(0)/g' {} \;
            '';
        }))
      ];
    };
    tmp.cleanOnBoot = true;
    kernelParams = ["systemd.show_status=auto" "amd_pstate=active"] ++ lib.optionals config.boot.plymouth.enable ["plymouth.use-simpledrm"];
    loader = {
      timeout = 2;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      systemd-boot = {
        enable = true;
        editor = false;
        consoleMode = "max";
        configurationLimit = 10;
      };
    };
  };

  # TODO Support CPU Power Here? Or Kernel Specific CPU Power Support in Hosts
}
