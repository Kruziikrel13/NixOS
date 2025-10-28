{
  pkgs,
  ...
}:
{
  # Personal Module - Hyprland Config handles Hyprland setup
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  qt.enable = true;
  environment = {
    systemPackages = [ hyprqt6engine.packages.${system}.hyprqt6engine ];
    sessionVariables.QT_QPA_PLATFORMTHEME = "hyprqt6engine";
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
  };
  xdg.portal.extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];

  security.polkit.enable = true;
}
