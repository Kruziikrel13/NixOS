{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (config.modules.profiles) hardware;
  inherit (lib.modules) mkIf;
  inherit (lib)
    mkMerge
    elem
    any
    hasPrefix
    ;
in
mkIf (any (s: hasPrefix "gpu/amd" s) hardware) (mkMerge [
  {
    user.extraGroups = [ "video" ];
    environment.variables.AMD_VULKAN_ICD = "RADV";
    environment.variables.VDPAU_DRIVER = "radeonsi";
    hardware.amdgpu.initrd.enable = true;
    hardware.graphics = {
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
  }
  (mkIf (elem "gpu/amd/overclock" hardware) {
    hardware.amdgpu.overdrive = {
      enable = true;
      ppfeaturemask = "0xffffffff";
    };
    services.lact.enable = true;
  })
])
