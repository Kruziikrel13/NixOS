{
  wayland.windowManager.hyprland.settings.windowrule = [
    "tag +game, class:^(steam_app).*"
    "tag +game, class:^(.*\.exe)$"
    "tag +game,  class:^(gamescope|\.gamescope-wrapped)$"
    "tag +game, title:^(.*minecraft.*)$"

    "tag -game, tag:game, title:^([Ww]ine.*)$"
    "tag -game, tag:game, class:^([Ww]ine.*)$"
    "tag -game, tag:game, title:^(REDlauncher)$"

    "tag +gaming, class:^([Ss]team)$"
    "tag +gaming, class:^(heroic)$"
    "tag +gaming, class:^(.*Prism.*)$"
    "tag +gaming, tag:game"
    "float, class:^([Ss]team)$, title:negative:^([Ss]team)$"
    "float, title:^(Wine)$, class:^(wineboot.exe)$"

    "tag +chat, class:^(vesktop)$"
    "tag +chat, class:^(Element)$"
    "tag +email, class:^(Proton Mail)$"

    "tag +video, class:^(cef)$, initialTitle:^(Grayjay)$"
    "tag +video, title:^(Picture-in-Picture)$"

    "float, class:^(\.blueman).*"
    "float, stayfocused, class:^(.*\.exe)$, title:^(.*[Ee]rror.*)$"
  ];
}
