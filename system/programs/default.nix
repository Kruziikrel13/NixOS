{
  pathLib,
  pkgs,
  ...
}:
{
  imports = pathLib.scanPaths ./.;
  environment.systemPackages = [
    pkgs.runapp
    pkgs.prismlauncher
  ];
  programs = {
    dconf.enable = true;
    neovim.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
}
