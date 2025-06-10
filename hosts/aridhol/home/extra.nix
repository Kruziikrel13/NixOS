{pkgs, ...}: {
  home.packages = [ pkgs.sutils ];
  xdg.dataFile.wallpaper = {
    enable = true;
    source = ./wallpaper.jpg;
  };
}
