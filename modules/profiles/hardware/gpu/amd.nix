{ lib, config, ... }:
with lib;
mkIf (any (s: hasPrefix "gpu/amd" s) config.modules.profiles.hardware) (mkMerge [
  {
    hardware = {
      amdgpu.initrd.enable = true;
      graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [
          libva
          libva-vdpau-driver
          libvdpau-va-gl
        ];
        extraPackages32 = with pkgs.driversi686Linux; [
          libva-vdpau-driver
          libvdpau-va-gl
        ];
      };
    };

    environment.variables = {
      AMD_VULKAN_ICD = "RADV";
      VDPAU_DRIVER = "radeonsi";
    };
  }

  (mkIf (elem "gpu/amd/overclock" config.modules.profiles.hardware) {
    # Enable driver support for AMD GPU overclocking
    hardware.amdgpu.overdrive = {
      enable = true;
      ppfeaturemask = "0xffffffff";
    };

    # Overclocking software
    services.lact.enable = true;
  })
])
