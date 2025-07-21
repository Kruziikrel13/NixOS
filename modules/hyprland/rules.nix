{
  wayland.windowManager.hyprland.settings.windowrule = [
    # Floating Windows
    "float, title:^(Friends List)$, class:^(steam)$"

    # Games
    # "content game, class:^(steam_app_.*)$"
    # "content game, title:.*\.exe"
    # "workspace 2, content: game"
    # "idleinhibit always, content: game"
    # "immediate, content: game"
    # "fullscreen, content: game"

    ## Temp while the above doesn't work
    "workspace 2, class:^(steam_app_.*)$"
    "idleinhibit always, class:^(steam_app_.*)$"
    "immediate, class:^(steam_app_.*)$"
    "fullscreen, class:^(steam_app_.*)$"

    "workspace 2, class:^(.*\.exe)$"
    "idleinhibit class:^(.*\.exe)$"
    "fullscreen, class:^(.*\.exe)$"
    "immediate, class:^(.*\.exe)$"

    # Custom Windows
    "float, class:ghostty.small"
    "size 35% 35%, class:ghostty.small"
    "move onscreen cursor -50% -50%, class:ghostty.small"

    "float, class:ghostty.tui"
    "move onscreen 100%-w-50 50, class:ghostty.tui"
    "stayfocused, class:ghostty.tui"
    "dimaround, class:ghostty.tui"

    # Workspace Assignments
    "workspace 8 silent, title:^(Proton Mail)$"
    "workspace 9 silent, class:^(vesktop)$"
    "workspace 10 silent, class:^(spotify)$"

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
    "idleinhibit fullscreen, class:^(zen)$"

    # xwayland
    "noblur, class:^()$,title:^()$"
    ## "noblur, xwayland:1"
    "nodim, xwayland:1"
    "noshadow, xwayland:1"
    "rounding 0, xwayland:1"
    "nofocus, class:^$, title:^$, xwayland:1, floating:1, fullscreen:0, pinned:0"
  ];
}
