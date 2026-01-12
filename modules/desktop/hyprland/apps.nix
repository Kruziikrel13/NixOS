{
  programs.hyprland.settings.windowrule = [
    "match:class ^(steam_app.*|.*\.exe|gamescope|\.gamescope-wrapped)$, tag + game"
    "match:title ^(.*minecraft.*)$, tag + game"

    "match:tag game, match:title ^([Ww]ine.*|REDlauncher|Rockstar Games Launcher)$, tag -game"
    "match:class ^(explorer.exe|socialclubhelper.exe)$, tag -game"

    "match:class ([Ss]team|heroic|.*Prism.*), tag +gaming"
    "match:tag game, tag +gaming"

    "match:class ^([Ss]team)$, match:title negative:^([Ss]team)$, float on"
    "match:class wineboot.exe, match:title Wine, float on"
    "match:class ^(vesktop|Element)$, tag +chat"
    "match:class ^(Proton Mail)$, tag +email"
    "match:class ^(cef)$, match:initial_title ^(Grayjay)$, tag +video"
    "match:title ^(Picture-in-Picture)$, tag +video"
    "match:class ^(\.blueman)$, float on"
    "match:class ^(.*\.exe)$, match:title .*([Ee]rror).*, float on, stay_focused on"
  ];
}
