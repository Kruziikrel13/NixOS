self: nix-gaming:
{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;
  cfg = config.personalModule.gaming;
in
{
  imports = [ nix-gaming.nixosModules.platformOptimizations ];
  options.personalModule.gaming.enable = mkEnableOption "Enable gaming optimizations and tools.";

  config = mkIf cfg.enable {
    powerManagement.cpuFreqGovernor = "performance";
    hardware = {
      steam-hardware.enable = true;
      amdgpu.overdrive.ppfeaturemask = "0xffffffff";
    };
    boot = {
      kernelPackages = pkgs.linuxPackages_xanmod_stable;
      kernelParams = [
        "threadirqs"
        "processor.max_cstate=5"
        "idle=nomwait"
        "pcie_aspm=off"
        "usbcore.autosuspend=-1"
      ];
    };
    programs = {
      gamemode = {
        enable = true;
        settings.general = {
          softrealtime = "auto";
          renice = 15;
        };
      };
      steam = {
        enable = true;
        platformOptimizations.enable = true;
        protontricks.enable = true;
        extraCompatPackages = [
          pkgs.proton-ge-bin
          pkgs.steamtinkerlaunch
        ];
      };
    };
  };
}
