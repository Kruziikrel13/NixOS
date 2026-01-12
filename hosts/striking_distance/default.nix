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
        monitors = [
          {
            output = "HDMI-A-1";
            mode = "1920x1080@144";
            position = "-1920x344";
          }
          {
            output = "DP-2";
            mode = "3840x2160@144";
            position = "0x0";
            primary = true;
          }
          {
            output = "HDMI-A-2";
            mode = "1920x1080@144";
            position = "3840x849";
          }
        ];
      };
      gaming.enable = true;
      apps = {
        steam.enable = true;
        minecraft.enable = true;
        grayjay.enable = true;
        heroic.enable = true;
        proton-mail.enable = true;
      };
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
    };
  };

  imports = pathLib.scanPaths ./. ++ [
    nixos-hardware.nixosModules.common-cpu-amd-raphael-igpu
  ];

  networking.hostName = "striking-distance";
  time.hardwareClockInLocalTime = true;

  # programs.hyprland = {
  #   monitors = [
  #     "desc:GIGA-BYTE TECHNOLOGY CO. LTD. AORUS FI32U 21440B000115,3840x2160@144.0,1920x0,1.0, bitdepth, 10"
  #     "desc:ViewSonic Corporation VX2758-C-MH V9M184500179,1920x1080@144.0,5760x849,1.0"
  #     "desc:AOC 24G1WG4 0x0004A33C,1920x1080@144.0,0x344,1.0"
  #   ];
  #   workspaces = [
  #     "1,monitor:desc:AOC 24G1WG4 0x0004A33C,default:true"
  #     "2,monitor:desc:GIGA-BYTE TECHNOLOGY CO. LTD. AORUS FI32U 21440B000115,default:true"
  #     "3,monitor:desc:ViewSonic Corporation VX2758-C-MH V9M184500179,default:true"
  #   ];
  # };
}
