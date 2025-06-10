{config, ...}: {
  xdg.configFile.monitors = {
    enable = true;
    target = "hypr/monitors.conf";
    text = ''
      monitor=desc:Chimei Innolux Corporation 0x1553,1920x1080@60.0,0x0,0.9999999999999997,bitdepth,10
    '';
  };

  xdg.configFile.workspaces = {
    enable = true;
    target = "hypr/workspaces.conf";
    text = ''
      workspace=1,monitor:desc:AOC 24G1WG4 0x0004A33C,default:true
      workspace=2,monitor:desc:GIGA-BYTE TECHNOLOGY CO. LTD. AORUS FI32U 21440B000115,default:true
      workspace=3,monitor:desc:ViewSonic Corporation VX2758-C-MH V9M184500179,default:true
      workspace=10,monitor:desc:AOC 24G1WG4 0x0004A33C
      workspace=9,monitor:desc:ViewSonic Corporation VX2758-C-MH V9M184500179
    '';
  };

  wayland.windowManager.hyprland = {
    sourceFirst = true;
    settings = {
      animations.enabled = false;
      gestures.workspace_swipe = true;
      source = [
        "${config.xdg.configHome}/hypr/monitors.conf"
        "${config.xdg.configHome}/hypr/workspaces.conf"
      ];
    };
  };
}
