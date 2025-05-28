{config, ...}: let
  cursorName = "Bibata-Modern-Classic-Hyprcursor";
in {
  wayland.windowManager.hyprland.settings = {
    env = [
      "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
      "HYPRCURSOR_THEME,${cursorName}"
      "HYPRCURSOR_SIZE,${toString config.home.pointerCursor.size}"
      # See https://github.com/hyprwm/contrib/issues/142
      "GRIMBLAST_NO_CURSOR,0"
    ];

    exec-once = [
      "uwsm finalize"
      "hyprctl setcursor ${cursorName} ${toString config.home.pointerCursor.size}"
    ];

    "$terminal" = "ghostty";
    "$dmenu" = "anyrun";
    "$mod" = "SUPER";

    general = {
      gaps_in = 5;
      gaps_out = 5;
      border_size = 1;
      allow_tearing = true;
      "col.active_border" = "rgb(51A4E7)";
    };

    decoration = {
      rounding = 10;
      rounding_power = 3;

      blur = {
        enabled = true;
        brightness = 1.0;
        contrast = 1.0;
        noise = 0.01;

        vibrancy = 0.2;
        vibrancy_darkness = 0.5;

        passes = 4;
        size = 7;

        popups = true;
        popups_ignorealpha = 0.2;
      };

      shadow = {
        enabled = true;
        color = "rgba(00000055)";
        ignore_window = true;
        offset = "0 15";
        range = 100;
        render_power = 2;
        scale = 0.97;
      };
    };

    animations = {
      enabled = true;
      animation = [
        "border, 1, 2, default"
        "fade, 1, 4, default"
        "windows, 1, 3, default, popin 80%"
        "workspaces, 1, 2, default, slide"
      ];
    };

    group = {
      groupbar = {
        font_size = 10;
        gradients = false;
        text_color = "rgb(b6c4ff)";
      };

      "col.border_active" = "rgba(35447988)";
      "col.border_inactive" = "rgba(dce1ff88)";
    };

    dwindle = {
      force_split = 2;
      preserve_split = true;
      pseudotile = true;
      precise_mouse_move = true;
    };

    input = {
      kb_variant = ",qwerty";
      kb_options = "grp:alt_shift_toggle";
      kb_model = "pc104";
      follow_mouse = true;
      accel_profile = "flat";
    };

    misc = {
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
      force_default_wallpaper = 0;
      # disable_autoreload = true;
      animate_mouse_windowdragging = false;
    };

    debug.disable_logs = false;

    xwayland.force_zero_scaling = true;

    cursor = {default_monitor = "DP-1";};
    experimental.xx_color_management_v4 = true;
  };
}
