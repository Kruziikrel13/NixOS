{
  imports = [ ./apprules.nix ];
  wayland.windowManager.hyprland.settings.windowrule = [
    # Floating Windows
    "center 1, floating:1, xwayland:0"

    # Gaming
    "workspace name:gaming, tag:gaming"
    "idleinhibit always, tag:game"
    "immediate, tag:game"
    "fullscreen, tag:game"

    "idleinhibit fullscreen, tag:video"

    # Custom Windows
    "float, class:ghostty.small"
    "size 35% 35%, class:ghostty.small"
    "move onscreen cursor -50% -50%, class:ghostty.small"

    "float, class:ghostty.tui"
    "move onscreen 100%-w-50 50, class:ghostty.tui"
    "stayfocused, class:ghostty.tui"
    "dimaround, class:ghostty.tui"

    # Workspace Assignments
    "workspace name:email, tag:email"
    "workspace name:chat, tag:chat"
    "workspace name:music, tag:music"

    # PiP
    "float, title:^(Picture-in-Picture)$"
    "pin, title:^(Picture-in-Picture)$"
    "keepaspectratio, title:^(Picture-in-Picture)$"

    # Dialogue Windows
    "center, title:^(Open File)(.*)$"
    "center, title:^(Select a File)(.*)$"
    "center, title:^(Choose wallpaper)(.*)$"
    "center, title:^(Save As)(.*)$"
    "center, title:^(Library)(.*)$"
    "center, title:^(File Upload)(.*)$"
    "float, title:^(Open File)(.*)$"
    "float, title:^(Select a File)(.*)$"
    "float, title:^(Choose wallpaper)(.*)$"
    "float, title:^(Open Folder)(.*)$"
    "float, title:^(Save As)(.*)$"
    "float, title:^(Library)(.*)$"
    "float, title:^(File Upload)(.*)$"

    ## General Window Rules
    "noshadow, floating: 0"
    "idleinhibit focus, class:^(mpv)$"
    "idleinhibit focus, class:^(zen)$, title:^(.*YouTube.*)$"

    # xwayland
    "noblur, class:^()$,title:^()$"
    "nodim, xwayland:1"
    "noshadow, xwayland:1"
    "rounding 0, xwayland:1"
    "nofocus, class:^$, title:^$, xwayland:1, floating:1, fullscreen:0, pinned:0"
    "noinitialfocus, class:^(jetbrains-).*,floating:1,title:^$|^\s$|^win\d+$"
    "noinitialfocus, class:^(Unity)$,floating:1"
  ];
}
