{config, ...}: let
  cfg_directory = "${config.xdg.configHome}/hypr";
in
{
  programs.hyprlock ={
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
}
