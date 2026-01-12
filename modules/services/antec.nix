{
  config,
  pkgs,
  lib,
  pkgs-patched,
  ...
}:
let
  inherit (lib.modules) mkIf;
  inherit (lib.meta) getExe;
  inherit (lib.types) str;
  inherit (lib.options) mkEnableOption mkOption;
  cfg = config.modules.services.antec;
  package = pkgs.antec-flux-pro;
in
{
  meta.maintainers = [ lib.maintainers.kruziikrel13 ];
  options.modules.services.antec = {
    enable = mkEnableOption "support for Antec Flux Pro GPU and CPU Temperature Sensor.";
    cpu-device = mkOption {
      type = str;
      description = "CPU temperature device name";
    };
    cpu-temp-type = mkOption {
      type = str;
      description = "CPU temperature sensor label";
    };
    gpu-device = mkOption {
      type = str;
      description = "GPU temperature device name";
    };
    gpu-temp-type = mkOption {
      type = str;
      description = "GPU temperature sensor label";
    };
  };
  config = mkIf cfg.enable {
    environment.systemPackages = [ package ];
    nixpkgs.overlays = [
      (final: prev: {
        inherit (pkgs-patched)
          antec-flux-pro
          ;
      })
    ];
    services.udev.packages = [ package.udev ];
    environment.etc."antec-flux-pro-display/config.conf".text = ''
      cpu_device=${cfg.cpu-device}
      cpu_temp_type=${cfg.cpu-temp-type}
      gpu_device=${cfg.gpu-device}
      gpu_temp_type=${cfg.gpu-temp-type}
      update_interval=1000
    '';

    systemd.services.antec-flux-pro-display = {
      unitConfig = {
        Description = "Antec Flux Pro Display Service";
        StartLimitIntervalSec = "0";
      };

      serviceConfig = {
        Type = "simple";
        ExecStartPre = "${pkgs.coreutils}/bin/sleep 5";
        ExecStart = getExe package;
        Restart = "always";
        RestartSec = "5";
        ProtectSystem = "strict";
        ProtectHome = "read-only";
        PrivateTmp = "true";
        NoNewPrivileges = "true";
      };

      wantedBy = [ "multi-user.target" ];
    };
  };
}
