{inputs, pkgs, ...}: {
  wayland.windowManager.hyprland = {
    plugins = [
      inputs.hyprspace.packages.${pkgs.system}.Hyprspace
    ];
    settings = {
      bind = [ "$mod, grave, overview:toggle" ];
    };
  };
}
