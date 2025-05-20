_: {
  programs.waybar = {
    settings.bar = {
      layer = "top";
      position = "top";
      height = 15;
      ipc = true;
      fixed-center = true;
      reload_on_style_change = true;
      modules-left = [
        "custom/os"
        "custom/separator"
        "hyprland/workspaces"
        "custom/separator"
        "hyprland/window"
      ];
      modules-center = [
        "tray"
        "custom/notifications"
        "custom/separator"
        "clock"
        "custom/separator"
        "custom/spotify-icon"
        "custom/spotify"
      ];
      modules-right = [
        "cpu"
        "memory"
        "disk"
        "network"
        "group/pulseaudio"
        "custom/separator"
        "custom/power"
      ];
      "hyprland/workspaces" = {
        format = "{icon}";
        all-outputs = true;
        format-icons = {
          "8" = "󰺻";
          "9" = "";
          "10" = "󰓇";
          default = "";
          empty = "";
        };
      };
      "hyprland/window" = {format = "{initialTitle}";};
      "clock" = {
        format = "{:%H:%M - %A %d}";
        tooltip = false;
        interval = 1;
      };
      "cpu" = {
        format = " {}%";
        on-click = "ghostty -e btop";
        interval = 10;
      };
      "memory" = {
        format = " {}%";
        interval = 30;
      };
      "disk" = {
        format = " {}%";
        interval = 60;
        path = "/";
        on-click = "ghostty --hold -e dust /";
      };
      "network" = {
        format-wifi = "";
        format-ethernet = "";
        format-disconnected = "";
        tooltip-format-disconnected = "Error";
        on-click = "alacritty -e nmtui";
      };
      "group/pulseaudio" = {
        orientation = "horizontal";
        drawer = {transition-duration = 500;};
        modules = ["pulseaudio" "pulseaudio/slider"];
      };
      "pulseaudio" = {
        format = "{icon}";
        format-muted = "󰸈";
        states = {
          low = 25;
          medium = "50";
          high = "75";
        };
        format-icons = ["󰕿" "󰖀" "󰕾"];
        on-click-right = "ghostty -e pulsemixer";
        on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
      };
      "pulseaudio/slider" = {
        min = 0;
        max = 100;
        orientation = "horizontal";
      };
      "custom/notifications" = {
        format = "";
        exec = "swaync-client -swb";
        exec-if = "which swaync-client";
        return-type = "json";
        on-click = "swaync-client -t -sw";
        escape = true;
        tooltip = false;
      };
      "custom/os" = {
        format = " ";
        tooltip = false;
      };
      "custom/separator" = {
        format = "";
        tooltip = false;
      };
      "custom/spotify-icon" = {
        format = " ";
        tooltip = false;
      };
      "custom/spotify" = {
        format = "{}";
        exec = "~/.config/waybar/scripts/mediaplayer.sh";
        exec-if = "pgrep spotify";
        interval = 1;
        return-type = "json";
        on-click = "playerctl -p spotify play-pause";
        on-scroll-up = "playerctl -p spotify next";
        on-scroll-down = "playerctl -p spotify previous";
      };
      "custom/power" = {format = "";};
      "tray" = {
        icon-size = 15;
        spacing = 10;
      };
    };
    style = ''
      @define-color background #171717;
      @define-color font #C4C4C4;
      @define-color font-secondary #525252;
      @define-color font-tertiary #414141;
      @define-color primary #51A4E7;

      * {
        font-size: 15px;
        font-family: "NotoSans Nerd Font Propo";
      }

      window#waybar {
        all: unset;
        background-color: @background;
        box-shadow: 0 4px 3px rgba(0,0,0,0.1);
      }

      .modules-left {
        padding: 7px;
        margin: 10px 10px 5px 0px;
      }

      .modules-center {
        padding: 7px;
        margin: 10px 0px 5px 0px;
      }

      .modules-right {
        padding: 7px;
        margin: 10px 10px 5px 0px;
      }

      #workspaces button {
        all: unset;
        padding: 0px 5px;
        color: @font-secondary;
        transition: all .2s ease;
      }

      #workspaces button.active {
        color: @font;
      }

      #systemd-failed-units, #cpu, #memory, #disk, #pulseaudio, #pulseaudio-slider, #network,
      #custom-notifications, #custom-spotify {
        color: @font;
        padding: 0px 5px;
        transition: all .2s ease;
      }

      #custom-separator {
        padding: 0px 7.5px;
      }

      #systemd-failed-units:hover, #cpu:hover, #memory:hover, #disk:hover, #pulseaudio:hover, #network:hover,
      #custom-notifications:hover, #custom-spotify:hover {
        color: @font-secondary;
        transition: all .2s ease;
      }

      #pulseaudio {
        font-size: 20px;
      }

      #pulseaudio-slider slider {
        min-height: 0px;
        min-width: 0px;
        opacity: 0;
        background-image: none;
        border: none;
        box-shadow: none;
      }

      #pulseaudio-slider trough {
        min-height: 10px;
        min-width: 80px;
        background-color: @font;
      }

      #pulseaudio-slider highlight {
        min-width: 0px;
        background-color: @primary;
      }

      #custom-os {
        padding: 0px 7.5px;
        background-image: url('../waybar/icons/os.svg');
        background-position: center;
        background-repeat: no-repeat;
        background-size: contain;
      }

      #custom-separator {
        color: @font-tertiary;
        padding: 0px 5px;
      }

      #custom-notifications {
        color: @font-secondary;
        padding: 0px 5px;
        transition: all .3s ease;
      }

      #custom-notifications.notification {
        color: #EBFF71;
        transition: all .3s ease;
      }

      #custom-spotify-icon {
        padding: 0px 5px;
        margin-left: 5px;
        background-image: url('../waybar/icons/spotify.svg');
        background-position: center;
        background-repeat: no-repeat;
        background-size: contain;
      }

      #custom-power {
        transition: all .3s ease;
      }

      #custom-power:hover {
        color: #9F4760;
        transition: all .3s ease;
      }

      #tray{
        padding: 0px 5px;
        transition: all .3s ease;

      }
      #tray menu * {
        padding: 0px 5px;
        transition: all .3s ease;
      }

      #tray menu separator {
        padding: 0px 5px;
        transition: all .3s ease;
      }
    '';
  };
}
