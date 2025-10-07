{
  paths,
  self,
  ...
}:
{
  imports = paths.scanPaths ./. ++ [
    self.nixosModules.antec
    self.nixosModules.keychron
  ];

  networking.hostName = "striking-distance";

  time.hardwareClockInLocalTime = true;

  environment.variables.AMD_VULKAN_ICD = "RADV";
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    logitech = {
      wireless.enable = true;
      wireless.enableGraphical = true;
    };
    antec = {
      enable = true;
      cpu-device = "k10temp-pci-00c3";
      cpu-temp-type = "Tctl";
      gpu-device = "amdgpu-pci-7700";
      gpu-temp-type = "edge";
    };
    keyboard.keychron = {
      enable = true;
      idProduct = "0161"; # Keychron Q6
    };
  };

  services = {
    ratbagd.enable = true;
  };

  programs.hyprland = {
    monitors = [
      "desc:GIGA-BYTE TECHNOLOGY CO. LTD. AORUS FI32U 21440B000115,3840x2160@144.0,1920x0,1.0, bitdepth, 10"
      "desc:ViewSonic Corporation VX2758-C-MH V9M184500179,1920x1080@144.0,5760x849,1.0"
      "desc:AOC 24G1WG4 0x0004A33C,1920x1080@144.0,0x344,1.0"
    ];
    workspaces = [
      "1,monitor:desc:AOC 24G1WG4 0x0004A33C,default:true"
      "2,monitor:desc:GIGA-BYTE TECHNOLOGY CO. LTD. AORUS FI32U 21440B000115,default:true"
      "3,monitor:desc:ViewSonic Corporation VX2758-C-MH V9M184500179,default:true"
    ];
  };
}
