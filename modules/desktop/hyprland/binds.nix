{ lib, pkgs, ... }:
{
  programs.hyprland.settings = {
    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];

    bindp = [
      "$mod, Q, killactive"
      "$mod SHIFT, Q, forcekillactive"
    ];

    bind = [
      "$mod, RETURN, exec, ${lib.meta.getExe pkgs.runapp} -- $terminal" # Launch Terminal
      "$mod SHIFT, RETURN, exec, runapp -- $terminal --class=ghostty.small" # Launch Terminal
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
}
