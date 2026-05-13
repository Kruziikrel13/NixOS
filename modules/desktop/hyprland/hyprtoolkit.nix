{
  lib,
  config,
  ...
}:
let
  inherit (lib.modules) mkIf;
  cfg = config.modules.desktop.hyprland;
in
mkIf cfg.enable {
  environment.etc."xdg/hypr/hyprtoolkit.conf".text = ''
    font_family = Inter
  '';
}
