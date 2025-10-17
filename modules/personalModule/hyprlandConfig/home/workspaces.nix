{
  # Default to monitors on main computer (striking-distance)
  wayland.windowManager.hyprland =
    let
      # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
      workspaces = builtins.concatLists (
        builtins.genList (
          x:
          let
            ws =
              let
                c = (x + 1) / 10;
              in
              builtins.toString (x + 1 - (c * 10));
          in
          [
            ", ${ws}, workspace, ${toString (x + 1)}"
            "SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
          ]
        ) 10
      );

    in
    {
      submaps.workspaces = {
        settings.bind = workspaces ++ [
          ", s, workspace, name:music"
          ", e, workspace, name:email"
          ", c, workspace, name:chat"
          ", g, workspace, name:gaming"
          ", catchall, submap, reset"
        ];
      };
      settings = {
        bind = [
          "$mod, 1, focusmonitor, desc:AOC 24G1WG4 0x0004A33C"
          "$mod SHIFT, 1, movewindow, mon:desc:AOC 24G1WG4 0x0004A33C"
          "$mod SHIFT, 1, centerwindow"
          "$mod, 2, focusmonitor, desc:GIGA-BYTE TECHNOLOGY CO. LTD. AORUS FI32U 21440B000115"
          "$mod SHIFT, 2, movewindow, mon:desc:GIGA-BYTE TECHNOLOGY CO. LTD. AORUS FI32U 21440B000115"
          "$mod SHIFT, 2, centerwindow"
          "$mod, 3, focusmonitor, desc:ViewSonic Corporation VX2758-C-MH V9M184500179"
          "$mod SHIFT, 3, movewindow, mon:desc:ViewSonic Corporation VX2758-C-MH V9M184500179"
          "$mod SHIFT, 3, centerwindow"

          "$mod, W, submap, workspaces"
        ];
        workspace = [
          "n[true], gapsout:0, gapsin:0, decorate:false, rounding:false"
          "name:gaming, monitor:desc:GIGA-BYTE TECHNOLOGY CO. LTD. AORUS FI32U 21440B000115"
          "name:music, monitor:desc:AOC 24G1WG4 0x0004A33C, on-created-empty: uwsm app -- spotify"
          "name:email, monitor:desc:ViewSonic Corporation VX2758-C-MH V9M184500179, on-created-empty: uwsm app -- proton-mail"
          "name:chat, monitor:desc:ViewSonic Corporation VX2758-C-MH V9M184500179, on-created-empty: uwsm app -- vesktop"
        ];
      };
    };
}
