{
  imports = [ ./apprules.nix ];
  wayland.windowManager.hyprland.settings.windowrule = [
    {
      name = "Center floating windows";
      "match:xwayland" = 0;
      "match:float" = 1;

      center = "on";
    }
    {
      name = "Gaming window rules";
      "match:tag" = "gaming";

      workspace = "name:gaming";
    }
    {
      name = "Game window rules";
      "match:tag" = "game";

      idle_inhibit = "always";
      immediate = "on";
      fullscreen = "on";
      float = "on";

      decorate = "off";
      rounding = "off";
      keep_aspect_ratio = "on";
    }
    {
      name = "Video window rules";
      "match:tag" = "video";

      content = "video";
      idle_inhibit = "on";
      fullscreen = "on";
    }
    {
      name = "Email workspace";
      "match:tag" = "email";

      workspace = "name:email";
    }
    {
      name = "Chat workspace";
      "match:tag" = "chat";

      workspace = "name:chat";
    }
    {
      name = "Open terminal on cursor";
      "match:class" = "ghostty.small";

      float = "on";
      size = "(monitor_w*0.35) (monitor_h*0.35)";
      move = "(cursor_x-window_w/2) (cursor_y-window_h/2)";
    }
    {
      name = "Quickshell TUI window";
      "match:class" = "ghostty.tui";

      float = "on";
      stay_focused = "on";
      dim_around = "on";
      size = "(monitor_w*0.35) (monitor_h*0.35)";
      move = "(monitor_w-window_w)-10 10";
    }
    {
      name = "Picture in Picture";
      "match:title" = "^(Picture-in-Picture)$";

      float = "on";
      pin = "on";
      keep_aspect_ratio = "on";
      render_unfocused = "on";
    }
    {
      name = "Dialogue windows";
      "match:title" =
        "^(Open File|Select EXE|Select a File|Choose wallpaper|Save As|Library|File Upload)";

      center = "on";
      float = "on";
    }
    # XWayland
    {
      name = "Some XWayland Fixes";
      "match:xwayland" = 1;

      no_dim = "on";
      no_shadow = "on";
      rounding = 0;
    }
  ];
}
