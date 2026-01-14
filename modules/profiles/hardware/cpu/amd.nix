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
    any
    hasPrefix
    ;
in
mkIf (any (s: hasPrefix "cpu/amd" s) hardware) (mkMerge [
  {
    boot.kernelParams = [ "amd-pstate=active" ];
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware; # TODO: AMD Cpu
  }
])
