{
  pkgs,
  config,
  ...
}:
{
  home.sessionVariables.WINEPREFIX = "${config.xdg.dataHome}/wine";
  home.packages = with pkgs; [
    wineWow64Packages.waylandFull
    heroic
    winetricks
    umu-launcher
  ];
}
