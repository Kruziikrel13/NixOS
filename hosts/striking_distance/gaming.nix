{
pkgs,
inputs,
...
}: {
  # Performance
  ## Xanmod may handle commented out boot kernel opts
  boot = {
    kernelPackages = pkgs.linuxPackages_xanmod;
    # kernelPatches = [{
    #   name = "preempt_rt";
    #   patch = null;
    # }];
    kernelParams = [ 
      "threadirqs"
      "amdgpu.ppfeaturemask=0xffffffff"
      "processor.max_cstate=5"
      "idle=nomwait"
      "pcie_aspm=off"
      "usbcore.autosuspend=-1"
    ];
  };
  powerManagement.cpuFreqGovernor = "performance";
  environment.systemPackages = with pkgs; [ steam-devices-udev-rules ];

  # See Keychron Support on Wiki https://github.com/Kruziikrel13/NixOS/wiki/Hardware-Fixes#keychron-keyboards
  services.udev.extraRules = ''
  SUBSYSTEM=="input", ATTRS{idVendor}=="3434", ATTRS{idProduct}=="0161", ENV{ID_INPUT_JOYSTICK}="" 
  ACTION=="add", SUBSYSTEM=="usb", TEST=="power/control", ATTR{power/control}="on"
  '';

  hardware.amdgpu = {
    amdvlk = {
      enable = true;
      support32Bit.enable = true;
      supportExperimental.enable = true;
    };
  };
  # Gaming Support
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
