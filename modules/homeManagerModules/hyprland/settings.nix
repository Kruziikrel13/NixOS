{
  config,
  osConfig,
  lib,
  ...
}:
let
  osCfg = osConfig.programs.hyprland;
  cursorName = "Bibata-Modern-Classic-Hyprcursor";
in
{
  wayland.windowManager.hyprland.settings = {
    env = [
      "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
      "HYPRCURSOR_THEME,${cursorName}"
      "HYPRCURSOR_SIZE,${toString config.home.pointerCursor.size}"
    ];
    source = lib.mkIf (osCfg.monitors != null || osCfg.workspaces != null) (
      (lib.optional (osCfg.monitors != null) "${config.xdg.configHome}/hypr/monitors.conf")
      ++ (lib.optional (osCfg.workspaces != null) "${config.xdg.configHome}/hypr/workspaces.conf")
    );

    exec-once = [
      "uwsm finalize"
      "hyprctl setcursor ${cursorName} ${toString config.home.pointerCursor.size}"
    ];

    "$terminal" = "ghostty";
    "$mod" = "SUPER";
    general = {
      layout = "master";
      gaps_in = 5;
      gaps_out = 5;
      border_size = 1;
      allow_tearing = true;
      no_focus_fallback = true;
      "col.active_border" = "rgb(51A4E7)";

      snap = {
        enabled = true;
      };
    };

    decoration = {
      rounding = 10;
      rounding_power = 3;

      blur = {
        new_optimizations = true;
        xray = true;
        popups = false;
        popups_ignorealpha = 0.2;

        brightness = 1.0;
        contrast = 1.0;
        noise = 0.01;
        vibrancy = 0.2;
        vibrancy_darkness = 0.5;

        passes = 4;
        size = 7;
      };

      shadow = {
        color = "rgba(00000055)";
        ignore_window = true;
        offset = "0 15";
        range = 100;
        render_power = 2;
        scale = 0.97;
      };
    };

    render.direct_scanout = 2;

    binds.scroll_event_delay = 10;

    animations = {
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
    };

    input = {
      kb_variant = ",qwerty";
      kb_options = "grp:alt_shift_toggle";
      kb_model = "pc104";
      follow_mouse = 1;
      accel_profile = "flat";
    };

    misc = {
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
      force_default_wallpaper = 0;
      animate_mouse_windowdragging = false;
      middle_click_paste = false;
      anr_missed_pings = 2;
      # disable_autoreload = true;
    };

    debug.disable_logs = false;

    xwayland.force_zero_scaling = true;

    cursor = {
      default_monitor = "DP-1";

    };
    experimental.xx_color_management_v4 = true;
  };
}
