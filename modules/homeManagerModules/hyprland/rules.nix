{
  wayland.windowManager.hyprland.settings.windowrule = [
    # Floating Windows
    "center 1, floating:1, xwayland:0"

    "float, class:^([Ss]team)$, title:negative:^([Ss]team)$"
    "float, title:^(Wine)$, class:^(wineboot.exe)$"
    "float, class:^(Slack)$, initialTitle:^(Huddle)$"
    "float, class:^(\.blueman).*"
    "pin, class:^(Slack)$, initialTitle:^(Huddle)$"

    # Games
    # "content game, class:^(steam_app_.*)$"
    # "content game, title:.*\.exe"
    # "workspace 2, content: game"
    # "idleinhibit always, content: game"
    # "immediate, content: game"
    # "fullscreen, content: game"

    ## Temp while the above doesn't work
    "workspace 2, class:^(steam_app).*"
    "idleinhibit always, class:^(steam_app).*"
    "immediate, class:^(steam_app).*"
    "fullscreen, class:^(steam_app).*"

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
    "workspace 2, class:^([Ss]team)$"
    "workspace 8, title:^(Proton Mail)$"
    "workspace 9, class:^(Slack)$"
    "workspace 9, class:^(vesktop)$"
    "workspace 10, class:^(spotify)$, initialTitle:^(Spotify( Premium)?)$"

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
  ];
}
