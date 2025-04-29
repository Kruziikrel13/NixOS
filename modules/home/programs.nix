{ osConfig, config, lib, pkgs, ... }:
let
  configDir = "/home/${osConfig.opts.Username}/.config";
in
{
  home.packages = with pkgs; [ walker pulsemixer protonmail-desktop discord spotify via nwg-displays ];
  services.playerctld.enable = true;
  programs.btop.enable = true;
  programs.bat.enable = true;
  programs.feh.enable = true;
  programs.fastfetch.enable = true;
  programs.ghostty = {
    enable = true;
    enableBashIntegration = true;
    installBatSyntax = true;
    installVimSyntax = true;
    settings = {
      theme = "GitHub Dark";
    };
  };
  programs.alacritty = {
    enable = false;
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
  programs.eww = {
    enable = true;
    enableBashIntegration = true;
  };
  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
  };
}
