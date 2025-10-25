{
  wayland.windowManager.hyprland.settings.windowrule = [
    "tag +game, class:^(steam_app).*"
    "tag +game, class:^(.*\.exe)$"
    "tag +game,  class:^(gamescope)$"

    "tag +gaming, class:^([Ss]team)$"
    "tag +gaming, class:^(heroic)$"
    "tag +gaming, tag:game"
    "float, class:^([Ss]team)$, title:negative:^([Ss]team)$"
    "float, title:^(Wine)$, class:^(wineboot.exe)$"

    "tag +chat, class:^(vesktop)$"
    "tag +email, class:^(Proton Mail)$"
    "tag +music, class:^(spotify)$, initialTitle:^(Spotify( Premium)?)$"

    "tag +video, class:^(cef)$, initialTitle:^(Grayjay)$"

    "float, class:^(\.blueman).*"
  ];
}
