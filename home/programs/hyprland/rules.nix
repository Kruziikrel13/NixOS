{
  wayland.windowManager.hyprland.settings = {
    windowrule = [
      "float, title:^(.*Bitwarden Password Manager.*)$"

      "float, title:^(Picture-in-Picture)$"
      "pin, title:^(Picture-in-Picture)$"

      "workspace special silent, title:^(Zen — Sharing Indicator)$"
      "workspace special silent, title:^(.*is sharing (your screen|a window)\.)$"

      # "content game, class:^(steam_app_.*)$"
      # "content game, title:.*\.exe"
      # "workspace 2, content: game"
      # "idleinhibit always, content: game"
      # "immediate, content: game"
      # "fullscreen, content: game"

      # Temp while the above doesn't work
      "workspace 2, class:^(steam_app_.*)$"
      "idleinhibit class:^(steam_app_.*)$"
      # "immediate, class:^(steam_app_.*)$"
      "fullscreen, class:^(steam_app_.*)$"

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

      "float, class:ghostty.small"
      "size 35% 35%, class:ghostty.small"
      "move onscreen cursor -50% -50%, class:ghostty.small"

      "float, class:ghostty.tui"
      "move onscreen 100%-w-50 50, class:ghostty.tui"
      "stayfocused, class:ghostty.tui"
      "dimaround, class:ghostty.tui"

      "workspace 8 silent, title:^(Proton Mail)$"
      "workspace 9 silent, class:^(vesktop)$"
      "workspace 10 silent, class:^(spotify)$"

      "idleinhibit focus, class:^(mpv)$"
      "idleinhibit focus, class:^(zen)$, title:^(.*YouTube.*)$"
      "idleinhibit fullscreen, class:^(zen)$"

      "dimaround, class:^(gcr-prompter)$"
      "dimaround, class:^(xdg-desktop-portal-gtk)$"
      "dimaround, class:^(zen)$, title:^(File Upload)$"

      "rounding 0, xwayland:1"
      "noblur, xwayland:1"
      "center, class:^(.*jetbrains.*)$, title:^(Confirm Exit|Open Project|win424|win201|splash)$"
      "size 640 400, class:^(.*jetbrains.*)$, title:^(splash)$"

      "scrolltouchpad 0.1, class:^(zen|firefox)$"
      "scrolltouchpad 0.1, class:^(xdg-desktop-portal-gtk)$"
    ];
  };
}
