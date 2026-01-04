{
  wayland.windowManager.hyprland.settings.windowrule = [
    {
      name = "Game";
      "match:class" = "^(steam_app.*|.*\.exe|gamescope|\.gamescope-wrapped)$";

      tag = "+game";
    }
    {
      name = "Game (2)";
      "match:title" = "^(.*minecraft.*)$";

      tag = "+game";
    }
    {
      name = "Remove game tag from launchers";
      "match:tag" = "game";
      "match:title" = "^([Ww]ine.*|REDlauncher|Rockstar Games Launcher)$";

      tag = "-game";
    }
    {
      name = "Remove game tag from other classes";
      "match:tag" = "game";
      "match:class" = "^(explorer.exe|socialclubhelper.exe)$";

      tag = "-game";
    }
    {
      name = "Gaming";
      "match:class" = "^([Ss]team|heroic|.*Prism.*)";

      tag = "+gaming";
    }
    {
      name = "Add gaming tag to games";
      "match:tag" = "game";

      tag = "+gaming";
    }
    {
      name = "Float steam popups"; # like friends list
      "match:class" = "^([Ss]team)$";
      "match:title" = "negative:^([Ss]team)$";

      float = "on";
    }
    {
      name = "Float wineboot";
      "match:class" = "wineboot.exe";
      "match:title" = "Wine";

      float = "on";
    }
    {
      name = "Chat applications";
      "match:class" = "^(vesktop|Element)$";

      tag = "+chat";
    }
    {
      name = "Email application";
      "match:class" = "Proton Mail";

      tag = "+email";
    }
    {
      name = "Tag Grayjay with video";
      "match:class" = "cef";
      "match:initial_title" = "Grayjay";

      tag = "+video";
    }
    {
      name = "Tag PiP with video";
      "match:title" = "Picture-in-Picture";

      tag = "+video";
    }
    {
      name = "Float blueman";
      "match:class" = "^(\.blueman)$";

      float = "on";
    }
    {
      name = "Keep exe errors focused";
      "match:class" = "^(.*\.exe)$";
      "match:title" = ".*([Ee]rror).*";

      float = "on";
      stay_focused = "on";

    }
  ];
}
