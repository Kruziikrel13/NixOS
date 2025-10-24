{
  imports = [ ./apprules.nix ];
  wayland.windowManager.hyprland.settings.windowrule = [
    # Floating Windows
    "center 1, floating:1, xwayland:0"

    # Gaming
    "workspace name:gaming, tag:gaming"
    "idleinhibit always, immediate, fullscreen, float, tag:game"
    "decorate off, rounding off, keepaspectratio, tag:game"

    "content video, tag:video"
    "idleinhibit fullscreen, tag:video"

    # Custom Windows
    "float, size 35% 35%, move onscreen cursor -50% -50%, class:ghostty.small"
    "float, stayfocused, dimaround, move onscreen 100%-w-50 50, class:ghostty.tui"

    # Workspace Assignments
    "workspace name:email, tag:email"
    "workspace name:chat, tag:chat"
    "workspace name:music, tag:music"

    # PiP
    "float, pin, keepaspectratio, title:^(Picture-in-Picture)$"

    # Dialogue Windows
    "center, float, title:^(Open File)(.*)$"
    "center, float, title:^(Select a File)(.*)$"
    "center, float, title:^(Choose wallpaper)(.*)$"
    "center, float, title:^(Save As)(.*)$"
    "center, float, title:^(Library)(.*)$"
    "center, float, title:^(File Upload)(.*)$"

    ## General Window Rules
    "noshadow, floating: 0"
    "idleinhibit focus, class:^(mpv)$"
    "idleinhibit focus, class:^(zen)$, title:^(.*YouTube.*)$"

    # xwayland
    "noblur, class:^()$,title:^()$"
    "nodim, noshadow, rounding 0, xwayland:1"
    "nofocus, class:^$, title:^$, xwayland:1, floating:1, fullscreen:0, pinned:0"
    "noinitialfocus, class:^(jetbrains-).*,floating:1,title:^$|^\s$|^win\d+$"
    "noinitialfocus, class:^(Unity)$,floating:1"
  ];
}
