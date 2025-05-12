{pkgs, ...}: {
  home.packages = with pkgs; [ 
    wineWowPackages.wayland 
    gamescope
    prismlauncher
    winetricks
    protontricks
  ];
}
