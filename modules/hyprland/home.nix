self: hyprland: {
  config,
  osConfig,
  pkgs,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  osCfg = osConfig.programs.hyprland;
  cursor = "Bibata-Modern-Classic-Hyprcursor";
  cursorPackage = self.packages.${pkgs.system}.bibata-hyprcursor;
in {
  imports =
    [hyprland.homeManagerModules.default]
    ++ lib.optionals osCfg.enable [
      ./services
      ./binds.nix
      ./rules.nix
      ./settings.nix
    ];

  config = mkIf osCfg.enable {
    programs.bash.profileExtra = lib.mkIf osCfg.withUWSM ''
      if uwsm check may-start; then
        exec uwsm start hyprland-uwsm.desktop
      fi
    '';
    xdg.dataFile."icons/${cursor}".source = "${cursorPackage}/share/icons/${cursor}";
    # Generate a workspaces and monitors file if the user has specified them
    xdg.configFile.monitors = lib.mkIf (osConfig.programs.hyprland.monitors != null) {
      target = "hypr/monitors.conf";
      text = lib.hm.generators.toHyprconf {
        attrs = {
          monitor = osConfig.programs.hyprland.monitors;
        };
      };
    };
    xdg.configFile.workspaces = lib.mkIf (osConfig.programs.hyprland.workspaces != null) {
      target = "hypr/workspaces.conf";
      text = lib.hm.generators.toHyprconf {
        attrs = {
          workspace = osConfig.programs.hyprland.workspaces;
        };
      };
    };

    wayland.windowManager.hyprland = {
      enable = true;
      package = null;
      portalPackage = null;
      systemd = {
        enable = false;
        variables = ["--all"];
        extraCommands = [
          "systemctl --user stop graphical-session.target"
          "systemctl --user start hyprland-session.target"
        ];
      };
    };

    home.packages = with pkgs; [
      wl-clipboard
      wlr-randr
    ];

    home.sessionVariables = {
      MOZ_ENABLE_WAYLAND = "1";
      QT_QPA_PLATFORM = "wayland";
      SDL_VIDEODRIVER = "wayland,x11";
      XDG_SESSION_TYPE = "wayland";
    };

    systemd.user.targets.tray.Unit.Requires =
      lib.mkForce [config.wayland.systemd.target];
  };
}
