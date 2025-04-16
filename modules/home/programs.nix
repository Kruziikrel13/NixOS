{ osConfig, config, lib, pkgs, ... }:
let
  configDir = "/home/${osConfig.opts.Username}/.config";
in
{
  services.playerctld.enable = true;
  programs.btop.enable = true;
  programs.bat.enable = true;
  programs.feh.enable = true;
  programs.fastfetch.enable = true;
  programs.alacritty = {
    enable = true;
    theme = "github_dark";
    settings = {
      general = {
        live_config_reload = true;
        ipc_socket = true;
      };
      window = {
        opacity = 0.9;
        blur = true;
        dynamic_title = false;
      };
    };
  };
  programs.eza = {
    enable = true;
    enableBashIntegration = true;
    git = true;
    icons = "auto";
  };
}
