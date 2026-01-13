{
  pathLib,
  nixos-hardware,
  username,
  pkgs,
  ...
}:
{
  modules = {
    profiles = {
      user = username;
      role = "workstation";
      hardware = [
        "cpu/amd"
        "gpu/amd"
        "audio"
        "audio/realtime"
        "ssd"
        "wifi"
        "secureboot"
        "tpm"
        "peripherals/logitech"
        "peripherals/keychron"
      ];
    };
    desktop = {
      hyprland = {
        enable = true;
        autoLogin = true;
        monitors = [
          {
            output = "desc:AOC 24G1WG4 0x0004A33C";
            mode = "1920x1080@144.0";
            position = "-1920x344";
          }
          {
            output = "desc:GIGA-BYTE TECHNOLOGY CO. LTD. AORUS FI32U 21440B000115";
            mode = "3840x2160@144.0";
            position = "0x0";
            hdr = true;
            primary = true;
          }
          {
            output = "desc:ViewSonic Corporation VX2758-C-MH V9M184500179";
            mode = "1920x1080@144.0";
            position = "3840x849";
          }
        ];
      };
      term.default = "ghostty";
      editors.default = "nvim";
      gaming.enable = true;
      browsers.zen.enable = true;
      apps = {
        steam.enable = true;
        minecraft.enable = true;
        grayjay.enable = true;
        heroic.enable = true;
        proton-mail.enable = true;
        element.enable = true;
      };
    };
    shell = {
      gnupg.enable = true;
      git = {
        enable = true;
        email = "dev@michaelpetersen.io";
        signingKey = "F34EB44630C65A33";
      };
      direnv.enable = true;
    };
    services = {
      quickshell = {
        enable = true;
        systemd.enable = true;
        extraPackages = with pkgs.qt6; [
          qtimageformats
          qtmultimedia
        ];
      };
      antec = {
        enable = true;
        cpu-device = "k10temp-pci-00c3";
        cpu-temp-type = "Tctl";
        gpu-device = "amdgpu-pci-7700";
        gpu-temp-type = "edge";
      };
      hyprlauncher = {
        enable = true;
        launchPrefix = "${pkgs.runapp}/bin/runapp --";
        windowSize = "800 520";
      };
    };
  };

  imports = pathLib.scanPaths ./. ++ [
    nixos-hardware.nixosModules.common-cpu-amd-raphael-igpu
  ];

  networking.hostName = "striking-distance";
  time.hardwareClockInLocalTime = true;
}
