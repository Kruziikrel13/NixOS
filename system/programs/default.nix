{
  pathLib,
  ...
}:
{
  imports = pathLib.scanPaths ./.;

  programs = {
    dconf.enable = true;
    neovim.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
}
