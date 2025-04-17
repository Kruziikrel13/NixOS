{ config, osConfig, pkgs, ... }:
let
  configDir = "/home/${osConfig.opts.Username}/.config/hypr";
in
  {
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    plugins = with pkgs.hyprlandPlugins; [
      hyprbars hyprtrails hypr-dynamic-cursors hy3
    ];

    systemd = {
      enable = true;
      enableXdgAutostart = true;
    };

    settings = {
      source = [
        "${configDir}/monitors.conf"
        "${configDir}/workspaces.conf"
      ];

      "$terminal" = "alacritty";
      "$dmenu" = "walker --modules applications";
      "$mainMod" = "SUPER";

      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
      ];

      bindtd = [
        "$mainMod, RETURN, Open terminal, exec, $terminal"
        "$mainMod, SPACE, Toggle floating window, togglefloating"
        "$mainMod, D, Open dmenu, exec, $dmenu"
        "$mainMod, Q, Kill active window, killactive"
        "$mainMod, F, Fullscreen active window, fullscreen"
        "$mainMod, P, Toggle pseudotile, pseudo"
        "CTRL ALT, DELETE, Exit Hyprland, exit"
        "CTRL ALT, L, Lock Hyprland, exec, loginctl lock-session"
        "CTRL ALT, R, Reboot, exec, systemctl reboot"
        "CTRL ALT, M, Shutdown, exec, systemctl -i poweroff"
      ];

      bindt = [
        "$mainMod, up, movefocus, u"
        "$mainMod, K, movefocus, u"
        "$mainMod, down, movefocus, d"
        "$mainMod, J, movefocus, d"
        "$mainMod, left, movefocus, l"
        "$mainMod, H, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, L, movefocus, r"
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
        "$mainMod, mouse_right, focusmonitor, e+1"
        "$mainMod, mouse_left, focusmonitor, e-1"
      ];

      bindtl = [
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      bindtel = [
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- --limit 1"
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ --limit 1"
        ", XF86MonBrightnessUp, exec, brightnessctl s 10%+"
        ", XF86MonBrightnessDown, exec, brightnessctl s 10%-"
      ];

      bindtm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      general = {
        gaps_in = 0;
        gaps_out = 1;
        border_size = 0;
      };

      dwindle = {
        smart_split = true;
        preserve_split = true;
      };
      input = {
        kb_variant = ",qwerty";
        kb_options = "grp:alt_shift_toggle";
        kb_model = "pc104";
      };
      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };
      cursor = {
        default_monitor = "DP-1";
      };
      experimental = {
        xx_color_management_v4 = true;
      };

      windowrule = [
        "workspace 8, class:(Proton Mail)"
        "workspace 9, class:(discord)"
        "workspace 10, class:(spotify)"
      ];

      windowrulev2 = [
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      ];

    };
  };

  programs = {
    wlogout.enable = true;
    waybar = {
      enable = true;
      systemd = {
        enable = true;
      };
    };
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
        general = {
          hide_cursor = true;
        };
        background = [
          {
            path = "${configDir}/wallpapers/lockscreen.jpeg";
            blur_passes = 1;
            blur_size = 2;
            reload_time = 300;
            reload_cmd = "find ${configDir}/wallpapers -maxdepth 1 -type f ! -name '*wallpaper.jpeg' ! -name '*lockscreen.jpeg' | shuf -n 1";
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
            placeholder_text = "<i>Password...</i>" ;

            position = "0, 120";
            halign = "center";
            valign = "bottom";
          }
        ];
      };
    };
  };

  systemd.user.services = {
    walker = {
      Unit = {
        Description = "Walker Service";
      };

      Service = {
        Type = "simple";
        ExecStart = "walker --gapplication-service";
      };
    };
    randomize-wallpaper = {
      Unit = {
        Description = "Randomize Wallpaper";
        Requires = "hyprpaper.service";
        After = "hyprpaper.service";
      };

      Service = {
        Type = "oneshot";
        ExecStart = "${configDir}/scripts/shuffle_wallpapers.sh";
      };
    };
  };

  systemd.user.timers = {
    randomize-wallpaper = {
      Unit = {
        Description = "Randomize Wallpaper - Hourly";
      };

      Timer = {
        OnCalendar = "hourly";
        Persistent = "true";
        Unit = "randomize-wallpaper.service";
      };

      Install = {
        WantedBy = [ "timers.target" ];
      };
    };
  };

  services = {
    swayosd.enable = true;
    swaync.enable = true;
    hyprpolkitagent.enable = true;
    hyprpaper = {
      enable = true;
      settings = {
        ipc = "on";
        splash = false;
        preload = [ "${configDir}/wallpapers/wallpaper.jpeg" ];
        wallpaper = [" , ${configDir}/wallpapers/wallpaper.jpeg"];
      };
    };
    hypridle = {
      enable = true;
      settings = {
        general = {
          ignore_dbus_inhibit = false;
          lock_cmd = "pidof hyprlock || hyprlock";
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = "hyprctl dispatch dpms on";
        };

        listener = [
          {
            timeout = 150;
            on-timeout = "brightnessctl -s set 10";
            on-resume = "brightnessctl -r";
          }

          {
            timeout = 360;
            on-timeout = "loginctl lock-session";
          }

          {
            timeout = 390;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on && brightnessctl -r";
          }

          {
            timeout = 1800;
            on-timeout = "systemctl suspend";
          }
        ];
      };
    };
  };
}
