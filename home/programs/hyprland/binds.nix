## https://github.com/fufexan/dotfiles
let
  # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
  workspaces = builtins.concatLists (builtins.genList (
      x: let
        ws = let
          c = (x + 1) / 10;
        in
          builtins.toString (x + 1 - (c * 10));
      in [
        "$mod, ${ws}, workspace, ${toString (x + 1)}"
        "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
      ]
    )
    10);
  toggle = program: let
    prog = builtins.substring 0 14 program;
  in "pkill ${prog} || uwsm app -- ${program}";
  once = program: "pgrep ${program} || uwsm app -- ${program}";
in {
  wayland.windowManager.hyprland.settings = {
    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];

    bind =
      [
        "$mod, RETURN, exec, uwsm app -T" # Launch Terminal
        "$mod SHIFT, RETURN, exec, uwsm app -- $terminal --class=ghostty.small" # Launch Terminal
        "$mod, Escape, exec, uwsm stop"
        "$mod, D, exec, ${toggle "$dmenu"}" # Launcher

        "$mod, Q, killactive"
        "$mod, F, fullscreen"
        "$mod, R, togglesplit"
        "$mod, T, togglefloating"
        "$mod, C, centerwindow"

        "$mod, L, movefocus, l"
        "$mod, H, movefocus, r"
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
      ]
      ++ workspaces;

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
}
