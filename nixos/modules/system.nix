{ config, lib, ... }:
with lib;
let cfg = config.opts.boot; in
  {
  options = with types; {
    opts.boot = {
      windows = {
        enable = mkEnableOption false;
        efiDeviceHandle = mkOption {
          type = str;
        };
      };
    };
  };
  config = {
    nix = {
      settings = {
        keep-outputs = false;
        keep-derivations = false;
        show-trace = false;
        auto-optimise-store = true;
        sandbox = true;
      };
      gc = {
        automatic = false;
        dates = "weekly";
        options = "--delete-old";
      };
      optimise = {
        automatic = true;
        dates = [ "monday" ];
      };
    };
    nixpkgs = {
      config.checkMeta = true;
      config.allowUnfree = true;
    };
    boot = {
      plymouth.enable = true;
      readOnlyNixStore = true;
      loader = {
        timeout = 5;
        systemd-boot = {
          enable = true;
          editor = false;
          consoleMode = "max";
          configurationLimit = 20;
          windows = mkIf cfg.windows.enable {
            "10-pro" = {
              title = "Windows 11 Pro";
              efiDeviceHandle = cfg.windows.efiDeviceHandle;
              sortKey = "a_windows";
            };
          };
        };
        efi = {
          canTouchEfiVariables = true;
          efiSysMountPoint = "/boot";
        };
      };
    };

  };
}
