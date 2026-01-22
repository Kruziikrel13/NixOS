{ lib, ... }:
{
  console.earlySetup = true;
  boot.loader = {
    timeout = 5;
    efi.canTouchEfiVariables = true;
    systemd-boot = {
      enable = lib.mkDefault true;
      editor = false;
      consoleMode = "max";
      configurationLimit = 10;
    };
  };
}
