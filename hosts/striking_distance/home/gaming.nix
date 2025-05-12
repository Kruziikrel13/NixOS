{pkgs, ...}: {
  home.packages = with pkgs; [ 
    wineWowPackages.wayland 
    gamescope
    winetricks
    protontricks
  ];
}
