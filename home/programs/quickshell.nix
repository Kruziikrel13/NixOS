{
  self,
  pkgs,
  osConfig,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
in {
  imports = [self.homeManagerModules.quickshell];

  config = mkIf osConfig.programs.hyprland.enable {
    programs.quickshell = {
      enable = true;
      systemd.enable = true;
      extraPackages = with pkgs.qt6; [qtimageformats qt5compat qtmultimedia];
      config = /etc/nixos/.config/quickshell;
    };

    qt = {
      enable = true;
      platformTheme.name = "qtct";
      style.name = "adwaita";
    };
  };
}
