{
inputs,
pkgs,
config,
...
}: 
if globals.desktop.widgets != "ags" then {}
else {
  imports = [ inputs.ags.homeManagerModules.default ];
  home.packages = [ 
    inputs.ags.packages.${pkgs.system}.io
    inputs.ags.packages.${pkgs.system}.notifd
    inputs.ags.packages.${pkgs.system}.tray
    inputs.ags.packages.${pkgs.system}.hyprland
    inputs.ags.packages.${pkgs.system}.mpris
    pkgs.gtk4
    pkgs.gtk4-layer-shell
  ];

  gtk = {
    enable = true;
    cursorTheme = {
      package = config.home.pointerCursor.package;
      name = config.home.pointerCursor.name;
      size = config.home.pointerCursor.size;
    };
    iconTheme = {
      name = "Adwaita";
      package =  pkgs.morewaita-icon-theme;
    };
    theme = {
      name = "Adwaita";
      package = pkgs.gnome-themes-extra;
    };
  };

  systemd.user.services = {
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

  programs.ags = {
    enable = true;
    systemd.enable = false;
    configDir = null;

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
}
