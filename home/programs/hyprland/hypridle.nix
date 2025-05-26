{config, ...}: let
  monitors = "${config.xdg.configHome}/hypr/monitors.conf";
in {
  services.hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = "pidof hyprlock || hyprlock";
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = "hyprctl dispatch dpms on; hyprctl keyword source ${monitors}";
        };

        listener = [
          {
            timeout = 360;
            on-timeout = "loginctl lock-session";
          }

          {
            timeout = 480;
            on-timeout = "hyprctl dispatch dpms off; hyprctl keyword monitor DP-2,disable";
            on-resume = "hyprctl dispatch dpms on; hyprctl keyword source ${monitors}";
          }

          {
            timeout = 1800;
            on-timeout = "systemctl suspend";
          }
        ];
      };
    };
}
