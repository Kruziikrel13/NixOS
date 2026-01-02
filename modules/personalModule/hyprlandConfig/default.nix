self: hyprland:
{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib.modules) mkIf;
  inherit (lib.types) nullOr listOf str;
  inherit (lib.options) mkOption;
in
{
  imports = [ hyprland.nixosModules.default ];
  options.programs.hyprland = {
    monitors = mkOption {
      type = nullOr (listOf str);
      default = null;
      description = "List of monitor identifiers for Hyprland.";
    };
    workspaces = mkOption {
      type = nullOr (listOf str);
      default = null;
      description = "List of workspace names for Hyprland.";
    };
  };

  config = mkIf config.programs.hyprland.enable {
    environment = {
      systemPackages = [ self.packages.${pkgs.system}.bibata-hyprcursor ];
      pathsToLink = [
        "/share/icons"
        "/share/wayland-sessions"
      ];
      sessionVariables = {
        NIXOS_OZONE_WL = "1";
        MOZ_ENABLE_WAYLAND = "1";
        SDL_VIDEODRIVER = "wayland";
        CLUTTER_BACKEND = "wayland";
        GTK_USE_PORTAL = "1";
        ELECTRON_OZONE_PLATFORM_HINT = "auto";
        QT_QPA_PLATFORM = "wayland";
        XDG_SESSION_TYPE = "wayland";
      };
      loginShellInit = mkIf config.programs.hyprland.withUWSM ''
        if uwsm check may-start; then
            exec uwsm start hyprland.desktop
          fi
      '';
    };
    nix.settings = {
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };

    home-manager.users.${config.personalModule.username} = {
      imports = [
        hyprland.homeManagerModules.default
        ./home
      ];

      wayland.windowManager.hyprland = {
        enable = true;
        package = null;
        portalPackage = null;
        systemd = {
          enable = false;
          variables = [ "--all" ];
          extraCommands = [
            "systemctl --user stop graphical-session.target"
            "systemctl --user start hyprland-session.target"
          ];
        };
      };
    };
  };
}
