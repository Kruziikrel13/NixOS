{
  self,
  pkgs,
  osConfig,
  pathLib,
  lib,
  ...
}:
let
  inherit (lib.modules) mkIf;
in
{
  imports = [ self.homeManagerModules.quickshell ];

  config = mkIf osConfig.programs.hyprland.enable {
    programs.quickshell = {
      enable = true;
      systemd.enable = true;
      extraPackages = with pkgs.qt6; [
        qtimageformats
        qtmultimedia
      ];
      config = pathLib.relativeToRoot "config/quickshell";
    };

    wayland.windowManager.hyprland = {
      settings = {
        misc = {
          allow_session_lock_restore = true;
          session_lock_xray = true;
          focus_on_activate = true;
        };
        bind = [
          "$mod, E, global, shell:powermenu"
          # "$mod, D, global, shell:launcher"
        ];
        layerrule = [
          {
            name = "Quickshell Bar";
            "match:namespace" = "shell:bar";

            animation = "slide";
            blur = "on";
          }
          {
            name = "Quickshell Powermenu";
            "match:namespace" = "shell:powermenu";

            animation = "slide right";
          }
          {
            name = "Quickshell Notifications";
            "match:namespace" = "shell:notifications";

            blur = "on";
            ignore_alpha = "0.1";
          }
        ];
      };
    };
  };
}
