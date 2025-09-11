{ pkgs, ... }:
{
  home.packages = [ pkgs.sutils ];
  wayland.windowManager.hyprland.settings = {
    animations.enabled = false;
    decoration = {
      shadow.enabled = false;
      blur.enabled = false;
    };
    gesture = [
      "3, left, workspace, m+1 "
      "3, right, workspace, m-1 "
      "3, up, float"
    ];
  };
}
