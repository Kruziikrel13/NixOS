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

  qt = {
    enable = true;
    style = "breeze";
    platformTheme = "qt5ct";
  };
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
  };
  xdg.portal.extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];

  security.polkit.enable = true;
}
