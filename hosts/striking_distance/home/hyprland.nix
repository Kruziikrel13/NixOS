{config, ...}: {
  xdg.configFile.monitors = {
    enable = true;
    target = "hypr/monitors.conf";
    text = ''
      monitor=desc:GIGA-BYTE TECHNOLOGY CO. LTD. AORUS FI32U 21440B000115,3840x2160@144.0,1920x0,1.0
      monitor=desc:ViewSonic Corporation VX2758-C-MH V9M184500179,1920x1080@60.0,5760x849,1.0
      monitor=desc:AOC 24G1WG4 0x0004A33C,1920x1080@144.0,0x344,1.0
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
      source = [
        "${config.xdg.configHome}/hypr/monitors.conf"
        "${config.xdg.configHome}/hypr/workspaces.conf"
      ];
      render = {
        direct_scanout = true;
        explicit_sync = 0;
        explicit_sync_kms = 0;
      };
    };
  };
}
