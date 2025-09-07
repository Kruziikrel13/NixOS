{
  paths,
  pkgs,
  inputs,
  ...
}:
let
  inherit (inputs) hyprqt6engine;
in
{
  imports = paths.scanPaths ./.;
  environment.systemPackages = [
    pkgs.kdePackages.breeze-icons
    pkgs.kdePackages.breeze
    hyprqt6engine.packages.${pkgs.system}.hyprqt6engine
  ];
  qt.enable = true;
  environment.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "hyprqt6engine";
  };

  programs = {
    hyprland = {
      enable = true;
      withUWSM = true;
    };
    dconf.enable = true;
    neovim.enable = true;
  };
}
