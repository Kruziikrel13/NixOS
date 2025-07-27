{config, ...}: {
  programs.hyprlock = {
    enable = true;
    extraConfig = ''
      # Hours
      label {
        monitor = DP-1
        font_size = 72
        text = $TIME
        shadow_passes = 3
        shadow_size = 4
        halign = left
        valign = bottom
        position = 30, 100
      }

      # Day
      label {
        monitor = DP-1
        text = cmd[update:18000000] echo "<b><big>"$(date +'%A')"</big></b>"
        font_size = 22
        font_family = JetBrainsMono Nerd Font 10

        position = 40, 78

        halign = left
        valign = bottom
      }

      # Week
      label {
        monitor = DP-1
        text = cmd[update:18000000] echo "<b>"$(date +'%d %b')"</b>"
        font_size = 18
        font_family = JetBrainsMono Nerd Font 10

        position = 40, 56

        halign = left
        valign = bottom
      }

      image {
        monitor = DP-1
        path = ${config.xdg.userDirs.pictures}/profile.png
        halign = right
        valign = bottom
        border_color = transparent
        size = 180
        rounding = 10
        position = -30, 50
      }
    '';
    settings = {
      general = {hide_cursor = true;};
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
