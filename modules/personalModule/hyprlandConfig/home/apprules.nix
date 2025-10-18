{
  wayland.windowManager.hyprland.settings.windowrule = [
    "tag +game, class:^(steam_app).*"
    "tag +game, class:^(.*\.exe)$"

    "tag +gaming, class:^([Ss]team)$"
    "tag +gaming, class:^(heroic)$"
    "tag +gaming, tag:game"
    "float, class:^([Ss]team)$, title:negative:^([Ss]team)$"
    "float, title:^(Wine)$, class:^(wineboot.exe)$"

    "tag +chat, class:^(vesktop)$"
    "tag +chat, class:^([Ss]lack)$"
    "tag +email, class:^(Proton Mail)$"
    "tag +music, class:^(spotify)$, initialTitle:^(Spotify( Premium)?)$"

    "float, class:^(\.blueman).*"
    "pin, class:^(Slack)$, initialTitle:^(Huddle)$"
    "float, class:^(Slack)$, initialTitle:^(Huddle)$"
  ];
}
