{paths, ...}: {
  imports = paths.scanPaths ./.;

  services.spotifyd.enable = true;
  programs = {
    dconf.enable = true;
    neovim.enable = true;
  };
}
