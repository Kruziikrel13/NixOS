{
  inputs,
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
    systemPackages = [ inputs.hyprqt6engine.packages.${pkgs.system}.hyprqt6engine ];
    sessionVariables.QT_QPA_PLATFORMTHEME = "hyprqt6engine";
  };

  security.polkit.enable = true;
}
