{
  pathLib,
  pkgs,
  ...
}:
{
  imports = pathLib.scanPaths ./.;
  programs = {
    dconf.enable = true;
    neovim.enable = true;
  };
}
