{
  pathLib,
  pkgs,
  ...
}:
{
  imports = pathLib.scanPaths ./.;
  home = {
    packages = with pkgs; [
      playerctl
      devenv
      cachix
    ];
    shellAliases.fix-store = "sudo nix-store --verify --check-contents --repair";
  };

  programs = {
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
