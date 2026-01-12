{
  programs.hyprland.settings = {
    "$mod" = "SUPER";
    "$terminal" = "ghostty";
    env = [
      "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
      "HYPRCURSOR_THEME,Bibata-Modern-Classic-Hyprcursor"
      "HYPRCURSOR_SIZE,${toString 16}"
    ];
    exec-once = [
      "hyprctl setcursor Bibata-Modern-Classic-Hyprcursor ${toString 16}"
    ];
    general = {
      layout = "master";
      gaps_in = 5;
      gaps_out = 5;
      border_size = 1;
      allow_tearing = true;
      no_focus_fallback = true;
      "col.active_border" = "rgb(C8C8C8)";
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
        color = "rgb(000000)";
        ignore_window = true;
        offset = "20 20";
        range = 100;
        render_power = 2;
        scale = 0.97;
      };
    };
    render.direct_scanout = 2;
    render.new_render_scheduling = true;
    binds.scroll_event_delay = 10;
    animation = [
      "border, 1, 2, default"
      "fade, 1, 4, default"
      "windows, 1, 3, default, popin 80%"
      "workspaces, 1, 2, default, slide"
    ];
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
      key_press_enables_dpms = true;
      # disable_autoreload = true;
    };
    debug.disable_logs = false;
    xwayland.force_zero_scaling = true;
  };
}
