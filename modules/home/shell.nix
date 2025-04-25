{ ... }:
{
  home.shell.enableBashIntegration = true;
  programs.bash = {
    enable = true;
  };
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };
}
