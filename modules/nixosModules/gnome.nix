self:
{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;
  cfg = config.programs.gnome;
in
{
  options.programs.gnome = {
    enable = mkEnableOption "Enable Gnome Desktop Environment";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs.gnomeExtensions; [ user-themes ];
    services = {
      displayManager.gdm = {
        enable = true;
        wayland = true;
      };
      desktopManager.gnome.enable = true;
      gnome.sushi.enable = true;
    };
  };
}
