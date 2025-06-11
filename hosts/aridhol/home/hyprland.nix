{config, ...}: {
  xdg.configFile.monitors = {
    enable = true;
    target = "hypr/monitors.conf";
    text = ''
      monitor=desc:Chimei Innolux Corporation 0x1553,1920x1080@60.0,0x0,0.9999999999999997,bitdepth,10
    '';
  };

  wayland.windowManager.hyprland = {
    sourceFirst = true;
    settings = {
      animations.enabled = false;
      gestures.workspace_swipe = true;
      source = [
        "${config.xdg.configHome}/hypr/monitors.conf"
      ];
    };
  };
}
