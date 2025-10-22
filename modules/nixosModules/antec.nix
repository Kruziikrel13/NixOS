self:
{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib.modules) mkIf;
  inherit (lib.meta) getExe;
  inherit (lib.types)
    str
    ;
  inherit (lib.options)
    mkEnableOption
    mkOption
    ;
  cfg = config.hardware.antec;
  myPkgs = self.packages.${pkgs.system};
in
{
  options.hardware.antec = {
    enable = mkEnableOption "Antec Flux Pro Display Service";
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
  config =
    let
      package = myPkgs.antec-flux-pro-display.override {
        cpu_device = cfg.cpu-device;
        cpu_temp_type = cfg.cpu-temp-type;
        gpu_device = cfg.gpu-device;
        gpu_temp_type = cfg.gpu-temp-type;
      };
    in
    mkIf cfg.enable {
      environment.systemPackages = [ package ];
      services.udev.packages = [ package.udev ];
      systemd.services.antec-flux-pro-display = {
        unitConfig = {
          Description = "Antec Flux Pro Display Service";
          StartLimitIntervalSec = "5";
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
          MemoryDenyWriteExecute = "true";
          RestrictRealtime = "true";

          LimitNOFILE = "1024";
          MemoryMax = "128M";
        };

        wantedBy = [
          "default.target"
          "multi-user.target"
        ];
      };
    };
}
