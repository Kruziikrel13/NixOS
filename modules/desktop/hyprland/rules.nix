{
  programs.hyprland.settings.windowrule = [
    "match:xwayland false, match:float true, center on"
    "match:tag gaming, workspace name:gaming"
    "match:tag game, idle_inhibit always, immediate on, fullscreen on, float on, decorate off, rounding off, keep_aspect_ratio on"
    "match:tag video, content video, idle_inhibit on, fullscreen on"
    "match:tag email, workspace name:email"
    "match:tag chat, workspace name:chat"
    "match:class ghostty.small, float on, size (monitor_w*0.35) (monitor_h*0.35), move (cursor_x-window_w/2) (cursor_y-window_h/2)"
    "match:class ghostty.tui, float on, stay_focused on, dim_around on, size (monitor_w*0.35) (monitor_h*0.35), move (monitor_w-window_w)-10 10"
    "match:title ^(Picture-in-Picture)$, float on, pin on, keep_aspect_ratio on, render_unfocused on"
    "match:title ^(Open File|Select EXE|Select a File|Choose wallpaper|Save As|Library|File Upload), center on, float on"
    "match:xwayland true, no_dim on, no_shadow on, rounding 0"
  ];
}
