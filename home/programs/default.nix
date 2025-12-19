{
  pathLib,
  pkgs,
  ...
}:
{
  imports = pathLib.scanPaths ./.;
  home = {
    shell.enableBashIntegration = true;
    packages = with pkgs; [
      grayjay
      pulsemixer
      protonmail-desktop
      via
      playerctl
      devenv
    ];
    shellAliases.fix-store = "sudo nix-store --verify --check-contents --repair";
  };

  programs = {
    bash = {
      enable = true;
      enableCompletion = true;
      enableVteIntegration = true;
      sessionVariables.GPG_TTY = "$(tty)";
    };
    direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
      silent = true;
    };
    element-desktop.enable = true;
    mpv = {
      enable = true;
      bindings = {
        r = "cycle_values video-rotate 90 180 270 0";
      };
    };
    ghostty = {
      enable = true;
      settings = {
        title = "Ghostty";
        theme = "GitHub Dark";

        window-decoration = false;
        confirm-close-surface = false;
        quit-after-last-window-closed = true;
      };
    };
  };
}
