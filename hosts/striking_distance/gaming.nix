{
pkgs,
inputs,
...
}: {
  boot.kernelPackages = pkgs.linuxPackages_xanmod;
  # See Keychron Support on Wiki https://github.com/Kruziikrel13/NixOS/wiki/Hardware-Fixes#keychron-keyboards
  services.udev.extraRules = ''
  SUBSYSTEM=="input", ATTRS{idVendor}=="3434", ATTRS{idProduct}=="0161", ENV{ID_INPUT_JOYSTICK}="" 
  '';
  # TODO Verify this is necessary
  programs = {
    gamescope = {
      enable = true;
      capSysNice = true;
      args = [
        "--rt"
        "--expose-wayland"
      ];
    };
    gamemode = {
      enable = true;
      settings = {
        general = {
          softrealtime = "auto";
          renice = 15;
        };
      };
    };

    steam = {
      enable = true;
      gamescopeSession.enable = true;
      platformOptimizations.enable = true;
      extraCompatPackages = [ pkgs.proton-ge-bin ];
    };
  };

  imports = [inputs.nix-gaming.nixosModules.platformOptimizations];
}
