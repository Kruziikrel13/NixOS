{
  # Default to monitors on main computer (striking-distance)
  wayland.windowManager.hyprland = {
    submaps.named_workspaces = {
      settings.bind = [
        ", s, workspace, name:music"
        ", s, submap, reset"
        ", e, workspace, name:email"
        ", e, submap, reset"
        ", c, workspace, name:chat"
        ", c, submap, reset"
        ", g, workspace, name:gaming"
        ", g, submap, reset"
        ", catchall, submap, reset"
      ];
    };
    settings.workspace = [
      "n[true], gapsout:0, gapsin:0, decorate:false, rounding:false"
      "name:gaming, monitor:desc:GIGA-BYTE TECHNOLOGY CO. LTD. AORUS FI32U 21440B000115"
      "name:music, monitor:desc:AOC 24G1WG4 0x0004A33C, on-created-empty: uwsm app -- spotify"
      "name:email, monitor:desc:ViewSonic Corporation VX2758-C-MH V9M184500179, on-created-empty: uwsm app -- proton-mail"
      "name:chat, monitor:desc:ViewSonic Corporation VX2758-C-MH V9M184500179, on-created-empty: uwsm app -- vesktop"
    ];
  };
}
