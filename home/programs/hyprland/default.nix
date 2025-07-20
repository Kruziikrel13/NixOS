{
  paths,
  config,
  osConfig,
  lib,
  pkgs,
  self,
  inputs,
  ...
}: let
  cursor = "Bibata-Modern-Classic-Hyprcursor";
  cursorPackage = self.packages.${pkgs.system}.bibata-hyprcursor;
in {
  imports =
    (
      if osConfig.programs.hyprland.enable
      then paths.scanPaths ./.
      else []
    )
    ++ [inputs.hyprland.homeManagerModules.default];
  config = lib.mkIf osConfig.programs.hyprland.enable {
    xdg.dataFile."icons/${cursor}".source = "${cursorPackage}/share/icons/${cursor}";

    programs.bash.profileExtra = lib.mkIf (osConfig.programs.hyprland.withUWSM) ''
      if uwsm check may-start; then
        exec uwsm start hyprland-uwsm.desktop
      fi
    '';
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
      sourceFirst = true;
    };

    # Generate a workspaces and monitors file if the user has specified them
    xdg.configFile.monitors = lib.mkIf (osConfig.hyprland.monitors != null) {
      target = "hypr/monitors.conf";
      text = lib.hm.generators.toHyprconf {
        attrs = {
          monitor = osConfig.hyprland.monitors;
        };
      };
    };
    xdg.configFile.workspaces = lib.mkIf (osConfig.hyprland.workspaces != null) {
      target = "hypr/workspaces.conf";
      text = lib.hm.generators.toHyprconf {
        attrs = {
          workspace = osConfig.hyprland.workspaces;
        };
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
