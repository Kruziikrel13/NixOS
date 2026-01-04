{ config, ... }:
let
  monitors = "${config.xdg.configHome}/hypr/monitors.conf";
in
{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on; hyprctl keyword source ${monitors}";
        inhibit_sleep = 3;
      };
      listener = [
        {
          timeout = 360;
          on-timeout = "loginctl lock-session";
        }

        {
          timeout = 480;
          on-timeout = "hyprctl dispatch dpms off; hyprctl keyword monitor HDMI-A-2,disable";
          on-resume = "hyprctl dispatch dpms on; hyprctl keyword source ${monitors}";
        }

        {
          timeout = 1800;
          on-timeout = "systemctl suspend || loginctl suspend";
        }
      ];
    };
  };
}
