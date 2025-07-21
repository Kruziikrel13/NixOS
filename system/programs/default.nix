{paths, ...}: {
  imports = paths.scanPaths ./.;

  programs = {
    hyprland = {
      enable = true;
      withUWSM = true;
    };
    dconf.enable = true;
    neovim.enable = true;
  };
}
