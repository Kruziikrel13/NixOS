{pkgs, config, ...}: {
  home.sessionVariables.WINEPREFIX = "${config.xdg.dataHome}/wine";
  home.packages = with pkgs; [ 
    wineWowPackages.wayland 
    gamescope
    winetricks
  ];
}
