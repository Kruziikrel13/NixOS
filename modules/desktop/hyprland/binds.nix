{ lib, pkgs, ... }:
let
  inherit (lib.meta) getExe;
in
{
  programs.hyprland = {
    settings = {
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      bindp = [
        "$mod, Q, killactive"
        "$mod SHIFT, Q, forcekillactive"
      ];

      bind = [
        "$mod, RETURN, exec, ${getExe pkgs.runapp} -- $terminal" # Launch Terminal
        "$mod SHIFT, RETURN, exec, ${getExe pkgs.runapp} -- $terminal --class=ghostty.small" # Launch Terminal
        "$mod, Escape, exec, uwsm stop"
        "$mod, D, exec, $dmenu" # Launcher

        "$mod, F, fullscreen"
        "$mod, R, togglesplit"
        "$mod, T, togglefloating"
        "$mod, C, centerwindow"

        "$mod, L, movefocus, r"
        "$mod, H, movefocus, l"
        "$mod, K, movefocus, u"
        "$mod, J, movefocus, d"

        "$mod, mouse_up, focusmonitor, r"
        "$mod, mouse_down, focusmonitor, l"

        # "$mod SHIFT, grave, movetoworkspace, special"
        # "$mod, grave, togglespecialworkspace, special"

        "$mod, bracketleft, workspace, m-1"
        "$mod, bracketright, workspace, m+1"

        "$mod SHIFT, bracketleft, focusmonitor, l"
        "$mod SHIFT, bracketright, focusmonitor, r"

        # Master Binds
        "$mod SHIFT, M, layoutmsg, swapwithmaster"
        "$mod SHIFT, H, layoutmsg, swapprev"
        "$mod SHIFT, L, layoutmsg, swapnext"
        "$mod, TAB, layoutmsg, cyclenext"
        "$mod SHIFT, TAB, cyclenext"

        "CTRL SHIFT, M, pass, class:^(vesktop)$"
        "CTRL SHIFT, D, pass, class:^(vesktop)$"
      ];

      bindl = [
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"

        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ];

      binde = [
        "$mod, right, resizeactive, 25 0"
        "$mod, left, resizeactive, -25 0"
        "$mod, up, resizeactive, 0 -25"
        "$mod, down, resizeactive, 0 25"
      ];

      bindle = [
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- --limit 1"
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ --limit 1"
      ];
    };
    # Workspaces Submap
    extraConfig =
      let
        workspaces = lib.concatStringsSep "\n" (
          lib.imap0 (
            i: _:
            let
              key = toString (lib.mod (i + 1) 10); # 1,2,3,4,5,6,7,8,9,0
              ws = toString (i + 1); # workspaces 1-10
            in
            "bind =, ${key}, workspace, ${ws}"
          ) (lib.range 1 10)
        );
      in
      ''
        workspace = name:gaming, monitor:desc:GIGA-BYTE TECHNOLOGY CO. LTD. AORUS FI32U 21440B000115
        workspace = name:email, monitor:desc:ViewSonic Corporation VX2758-C-MH V9M184500179, on-created-empty: runapp -- proton-mail
        workspace = name:chat, monitor:desc:ViewSonic Corporation VX2758-C-MH V9M184500179, on-created-empty: runapp -- vesktop
        bind = $mod, W, submap, workspaces
        submap = workspaces
        ${workspaces}
        bind=, e, workspace, name:email
        bind=, c, workspace, name:chat
        bind=, g, workspace, name:gaming
        bind=, catchall, submap, reset
        submap = reset
      '';
  };
}
