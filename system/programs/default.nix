{
  paths,
  ...
}:
{
  imports = paths.scanPaths ./.;

  programs = {
    dconf.enable = true;
    neovim.enable = true;
  };
}
