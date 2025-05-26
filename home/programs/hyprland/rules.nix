{
  wayland.windowManager.hyprland.settings = {
    windowrule = [
      "float, title:^(.*Bitwarden Password Manager.*)$"

      "float, title:^(Picture-in-Picture)$"
      "pin, title:^(Picture-in-Picture)$"

      "workspace special silent, title:^(Zen — Sharing Indicator)$"
      "workspace special silent, title:^(.*is sharing (your screen|a window)\.)$"
      
      "tag +steam_game, class:^(steam_app)"
      "content game, class:^(steam_app)"
      "workspace 2 silent, content:game"
      "idleinhibit always, content:game"
      "immediate, content:game"

      "workspace 9 silent, title:^(Proton Mail)$"
      "workspace 9 silent, title:^(Vesktop)$"
      "workspace 10 silent, title:^(Spotify ( Premium)?)$"

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
