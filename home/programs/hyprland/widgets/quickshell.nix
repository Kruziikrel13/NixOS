{ lib, ... }:
{
  options = {
    programs.quickshell = {
      enable = lib.mkEnableOption null;
      systemd.enable = lib.mkEnableOption null;
    };
  };
}
