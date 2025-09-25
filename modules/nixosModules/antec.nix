self:
{
  config,
  pkgs,
  lib,
  self,
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
    mkPackageOption
    ;

  cfg = config.services.antec-flux-pro;
in
{
  options.services.antec-flux-pro = {
    enable = mkEnableOption "Antec Flux Pro Display Service";
    package = mkPackageOption self.packages.${pkgs.system} "antec-flux-pro-display" {
      nullable = false;
    };
    cpu-device = mkOption {
      type = str;
      default = "k10temp";
      description = "CPU temperature device name";
    };
    cpu-temp-type = mkOption {
      type = str;
      default = "tctl";
      description = "CPU temperature sensor label";
    };
    gpu-device = mkOption {
      type = str;
      default = "amdgpu";
      description = "GPU temperature device name";
    };
    gpu-temp-type = mkOption {
      type = str;
      default = "edge";
      description = "GPU temperature sensor label";
    };
  };
  config = mkIf cfg.enable {
    environment = {
      systemPackages = [ cfg.package ];
      etc."antec-flux-pro-display/config.conf".text = ''
        cpu_device=${cfg.cpu-device}
        cpu_temp_type=${cfg.cpu-temp-type}
        gpu_device=${cfg.gpu-device}
        gpu_temp_type=${cfg.gpu-temp-type}
        update_interval=1000
      '';
    };
    services.udev.extraRules = ''
      SUBSYSTEM=="usb", ATTR{idVendor}=="2022", ATTR{idProduct}=="0522", MODE="0666", GROUP="plugdev"
      SUBSYSTEM=="usb", ATTR{idVendor}=="2022", ATTR{idProduct}=="0522", MODE="0666", GROUP="plugdev", TAG+="uaccess"
    '';
    systemd.services.antec-flux-pro-display = {
      unitConfig = {
        Description = "Antec Flux Pro Display Service";
        StartLimitIntervalSec = "5";
      };

      serviceConfig = {
        Type = "simple";
        ExecStartPre = "${pkgs.coreutils}/bin/sleep 5";
        ExecStart = getExe cfg.package;
        Restart = "always";
        RestartSec = "5";
        ProtectSystem = "strict";
        ProtectHome = "true";
        PrivateTmp = "true";
        NoNewPrivileges = "true";
      };

      wantedBy = [ "multi-user.target" ];
    };
  };
}
