{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [ walker pulsemixer protonmail-desktop spotify via nwg-displays tomato-c obsidian wine inputs.zen-browser.packages.${pkgs.system}.default limo ];
  services.playerctld.enable = true;
  programs.btop.enable = true;
  programs.bat.enable = true;
  programs.feh.enable = true;
  programs.ghostty = {
    enable = true;
    enableBashIntegration = true;
    installBatSyntax = true;
    installVimSyntax = true;
    settings = {
      theme = "GitHub Dark";
      title = "Ghostty";
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
  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
  };
  programs.superfile.enable = false;
  programs.vesktop = {
    enable = true;
    vencord.useSystem = true;
  };
}
