{
  lib,
  config,
  inputs,
  pkgs,
  root,
  ...
}: let
  cfg = config.programs.quickshell;
in {
  options = {
    programs.quickshell = {
      enable = lib.mkEnableOption null;
      systemd.enable = lib.mkEnableOption null;
    };
  };

  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = cfg.systemd.enable && (!config.programs.agsCustom.systemd.enable || !config.programs.ags.systemd.enable);
        message = "Service conflicts between Quickshell and AGS";
      }
    ];
    home.packages = [inputs.quickshell.packages.${pkgs.system}.default];
    programs.jq.enable = true;
    xdg.configFile.quickshell = {
      enable = true;
      source = config.lib.file.mkOutOfStoreSymlink "${root}/.config/quickshell";
    };
    systemd.user.services = lib.mkIf cfg.systemd.enable {
      quickshell = {
        Unit = {
          Description = "Quickshell Desktop Widget";
          PartOf = [config.wayland.systemd.target];
          Requires = [config.wayland.systemd.target];
          After = [config.wayland.systemd.target "tray.target"];
        };

        Service = {
          ExecStart = "${
            inputs.quickshell.packages.${pkgs.system}.default
          }/bin/quickshell";
          Restart = "on-failure";
          KillMode = "mixed";
        };

        Install.WantedBy = [config.wayland.systemd.target];
      };
    };
  };
}
