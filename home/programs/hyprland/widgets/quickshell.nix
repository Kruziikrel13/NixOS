{ 
  lib, 
  config, 
  inputs, 
  pkgs, 
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
        assertion = !config.programs.agsCustom.enable || !config.programs.ags.enable;
        message = "Quickshell widget conflicts with AGS widget. Only enable one.";
      }
    ];
    home.packages = [ inputs.quickshell.packages.${pkgs.system}.default ];
    xdg.configFile.quickshell = {
      enable = true;
      source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/config/quickshell;
    };
    systemd.user.services = lib.mkIf cfg.systemd.enable {
      quickshell = {
        Unit = {
          Description = "Quickshell Desktop Widget";
          PartOf = [ config.wayland.systemd.target ];
          Requires = [ config.wayland.systemd.target ];
          After = [ config.wayland.systemd.target "tray.target" ];
        };

        Service = {
          ExecStart = "${inputs.quickshell.packages.${pkgs.system}.default}/bin/quickshell";
          Restart = "on-failure";
          KillMode = "mixed";
        };

        Install.WantedBy = [ config.wayland.systemd.target ];
      };
    };
  };
}
