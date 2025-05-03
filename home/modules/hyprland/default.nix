{ config, pkgs, ... }:
let
  configDir = "${config.home.homeDirectory}/.config/hypr";
in
  {
  imports = [ ./waybar.nix ./eww.nix ./services.nix ];

  home.sessionVariables.NIXOS_OZONE_WL = "1";

  home.pointerCursor = {
    gtk.enable = true;
    enable = true;
    package = pkgs.rose-pine-hyprcursor;
    name = "rose-pine-hyprcursor";
    size = 32;
    hyprcursor.enable = true;
  };
  gtk.enable = true;

  programs.bash.profileExtra = ''
    if uwsm check may-start; then
      exec uwsm start hyprland-uwsm.desktop
    fi
  '';
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    systemd.enable = false;
    systemd.variables = [ "--all" ];

    settings = {
      source = [
        "${configDir}/monitors.conf"
        "${configDir}/workspaces.conf"
      ];

      "$terminal" = "ghostty";
      "$dmenu" = "walker --modules applications";
      "$mainMod" = "SUPER";

      env = [
        "XCURSOR_SIZE,32"
        "HYPRCURSOR_SIZE,32"
        "HYPRCURSOR_THEME,rose-pine-hyprcursor"
      ];

      bindtd = [
        "$mainMod, RETURN, Open terminal, exec, $terminal"
        "$mainMod, SPACE, Toggle floating window, togglefloating"
        "$mainMod, D, Open dmenu, exec, $dmenu"
        "$mainMod, Q, Kill active window, killactive"
        "$mainMod, F, Fullscreen active window, fullscreen"
        "$mainMod, P, Toggle pseudotile, pseudo"
        "CTRL ALT, DELETE, Exit Hyprland, exec, uwsm stop"
        "CTRL ALT, L, Lock Hyprland, exec, loginctl lock-session"
        "CTRL ALT, R, Reboot, exec, systemctl reboot"
        "CTRL ALT, M, Shutdown, exec, systemctl -i poweroff"
      ];

      bindt = [
        "$mainMod, up, movefocus, u"
        "$mainMod, K, movefocus, u"
        "$mainMod, down, movefocus, d"
        "$mainMod, J, movefocus, d"
        "$mainMod, left, movefocus, l"
        "$mainMod, H, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, L, movefocus, r"
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
        "$mainMod, mouse_right, focusmonitor, e+1"
        "$mainMod, mouse_left, focusmonitor, e-1"
      ];

      bindtl = [
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      bindtel = [
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- --limit 1"
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ --limit 1"
      ];

      bindtm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      general = {
        gaps_in = 0;
        gaps_out = 1;
        border_size = 0;
      };

      dwindle = {
        force_split = 2;
        preserve_split = true;
      };

      input = {
        kb_variant = ",qwerty";
        kb_options = "grp:alt_shift_toggle";
        kb_model = "pc104";
      };
      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };
      cursor = {
        default_monitor = "DP-1";
      };
      experimental = {
        xx_color_management_v4 = true;
      };

      windowrule = [
        "workspace 8, class:(Proton Mail)"
        "workspace 9, class:(discord)"
        "workspace 9, class:(vesktop)"
        "workspace 10, class:(spotify)"
      ];

      windowrulev2 = [
        "center, floating:1"
        "suppressevent maximize, class:.*"
        "idleinhibit fullscreen, class:^steam_app_*"
        "idleinhibit fullscreen, class:firefox"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      ];

    };
  };
}
