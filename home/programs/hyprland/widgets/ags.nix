{
inputs,
pkgs,
config,
lib,
...
}: let
  cfg = config.programs.agsCustom;
in {
  imports = [ inputs.ags.homeManagerModules.default ];
  options = {
    programs.agsCustom = {
      enable = lib.mkEnableOption null;
      systemd.enable = lib.mkEnableOption null;
    };
  };
  config = lib.mkIf cfg.enable {
    assertions = [ 
      { 
        assertion = !config.programs.quickshell.enable;
        message = "AGS Widget conflicts with Quickshell Widget, only enable One!";
      }
    ];
    home.packages = [ 
      inputs.ags.packages.${pkgs.system}.io
      inputs.ags.packages.${pkgs.system}.notifd
      inputs.ags.packages.${pkgs.system}.tray
      inputs.ags.packages.${pkgs.system}.hyprland
      inputs.ags.packages.${pkgs.system}.mpris
      pkgs.gtk4
      pkgs.gtk4-layer-shell
    ];
    programs.ags = {
      enable = true;
      systemd.enable = false;
      configDir = config.lib.file.mkOutOfStoreSymlink /etc/nixos/config/ags;

      extraPackages = with inputs.ags.packages.${pkgs.system}; [
        notifd
        io
        battery
        hyprland
        tray
        wireplumber
        apps
        network
        mpris
      ];
    };
    systemd.user.services = lib.mkIf cfg.systemd.enable {
      ags-tray = {
        Unit = {
          Description = "AGS Tray Daemon";
          PartOf = [ "tray.target" ];
        };
        Service = {
          ExecStart = "${inputs.ags.packages.${pkgs.system}.tray
        }/bin/astal-tray --daemonize";
          Restart = "on-failure";
          KillMode = "mixed";
        };
        Install.WantedBy = [ "tray.target" ];
      };
      ags-mpris = {
        Unit = {
          Description = "AGS MPRIS Daemon";
          PartOf = [ config.wayland.systemd.target ];
        };
        Service = {
          ExecStart = "${inputs.ags.packages.${pkgs.system}.mpris}/bin/astal-mpris monitor";
          Restart = "on-failure";
          KillMode = "mixed";
        };
        Install.WantedBy = [ config.wayland.systemd.target ];
      };
      ags-hyprland = {
        Unit = {
          Description = "AGS Hyprland Daemon";
          PartOf = [ config.wayland.systemd.target ];
        };
        Service = {
          ExecStart = "${inputs.ags.packages.${pkgs.system}.hyprland}/bin/astal-hyprland";
          Restart = "on-failure";
          KillMode = "mixed";
        };
        Install.WantedBy = [ config.wayland.systemd.target ];
      };
      ags = {
        Unit = {
          Description = "AGS Status Bar";
          Documentation = "https://github.com/Aylur/ags";
          PartOf = [ config.wayland.systemd.target ];
          Requires = [ "ags-tray.service" "ags-mpris.service" "ags-hyprland.service" ];
          After = [ config.wayland.systemd.target "ags-tray.service" "ags-mpris.service" "ags-hyprland.service" ];
        };
        Service = {
          ExecStart = "${config.programs.ags.finalPackage}/bin/ags run";
          Restart = "on-failure";
          KillMode = "mixed";
        };
        Install.WantedBy = [ config.wayland.systemd.target ];
      };
    };


  };
}
