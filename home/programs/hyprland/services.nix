{
  config,
  ...
}: let
  cfg_directory = "${config.xdg.configHome}/hypr";
  monitors = "${cfg_directory}/monitors.conf";
in {
  systemd.user.services = {
    randomize-wallpaper = {
      Unit = {
        Description = "Randomize Wallpaper";
        Requires = "hyprpaper.service";
        After = "hyprpaper.service";
      };

      Service = {
        Type = "oneshot";
        ExecStart = "${cfg_directory}/scripts/shuffle_wallpapers.sh";
      };
    };
  };

  systemd.user.timers = {
    randomize-wallpaper = {
      Unit = {Description = "Randomize Wallpaper - Hourly";};

      Timer = {
        OnCalendar = "hourly";
        Persistent = "true";
        Unit = "randomize-wallpaper.service";
      };

      Install = {WantedBy = ["timers.target"];};
    };
  };

  services = {
    swaync.enable = true;
    hyprpolkitagent.enable = true;
    hyprpaper = {
      enable = true;
      settings = {
        ipc = "on";
        splash = false;
        preload = ["${cfg_directory}/wallpapers/wallpaper.jpeg"];
        wallpaper = [" , ${cfg_directory}/wallpapers/wallpaper.jpeg"];
      };
    };
    hypridle = {
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
  };

  programs = {
    hyprlock = {
      enable = true;
      extraConfig = ''
        # Hours
        label {
          monitor = DP-1
          font_size = 112
          text = cmd[update:1000] echo "<b><big> $(date +"%H") </big></b>"
          shadow_passes = 3
          shadow_size = 4
          halign = center
          valign = center
          position = 0, 220
        }

        # Minutes
        label {
          monitor = DP-1
          text = cmd[update:1000] echo "<b><big> $(date +"%M") </big></b>"
          font_size = 112
          shadow_passes = 3
          shadow_size = 4

          position = 0, 80
          halign = center
          valign = center
        }

        # Day
        label {
          monitor = DP-1
          text = cmd[update:18000000] echo "<b><big> "$(date +'%A')" </big></b>"
          font_size = 22
          font_family = JetBrainsMono Nerd Font 10

          position = 0, -20
          halign = center
          valign = center
        }

        # Week
        label {
          monitor = DP-1
          text = cmd[update:18000000] echo "<b> "$(date +'%d %b')" </b>"
          font_size = 18
          font_family = JetBrainsMono Nerd Font 10

          position = 0, -60
          halign = center
          valign = center
        }
      '';
      settings = {
        general = {hide_cursor = true;};
        background = [
          {
            path = "${cfg_directory}/wallpapers/lockscreen.jpeg";
            blur_passes = 1;
            blur_size = 2;
            reload_time = 300;
            reload_cmd = "find ${cfg_directory}/wallpapers -maxdepth 1 -type f ! -name '*wallpaper.jpeg' ! -name '*lockscreen.jpeg' | shuf -n 1";
          }
        ];
        input-field = [
          {
            monitor = "DP-1";
            size = "250, 50";
            outline_thickness = 3;

            dots_size = 0.26; # Scale of input-field height, 0.2 - 0.8
            dots_spacing = 0.64; # Scale of dots' absolute size, 0.0 - 1.0
            dots_center = true;
            dots_rouding = -1;
            font_color = "rgba(255,255,255,1)";
            outer_color = "rgba(0,0,0,0)";
            inner_color = "rgba(0,0,0,0)";

            rounding = 22;
            fade_on_empty = true;

            position = "0, 120";
            halign = "center";
            valign = "bottom";
          }
        ];
      };
    };
  };
}
