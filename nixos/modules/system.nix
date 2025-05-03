{ globals, lib, ... }:
with lib;
{
  documentation.nixos.enable = false;
  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    experimental-features = "nix-command flakes";
    auto-optimise-store = true;
    warn-dirty = false;
  };

  boot = {
    plymouth.enable = true;
    tmp.cleanOnBoot = true;
    loader = {
      timeout = 2;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      systemd-boot = {
        enable = true;
        editor = false;
        consoleMode = "max";
        configurationLimit = 10;
        windows = mkIf globals.boot.windows.enable {
          "10-pro" = {
            title = "Windows 11 Pro";
            efiDeviceHandle = globals.boot.windows.efiDeviceHandle;
            sortKey = "a_windows";
          };
        };
      };
    };
  };
}
