{
  paths,
  self,
  pkgs,
  ...
}: {
  imports = paths.scanPaths ./.;
  environment.systemPackages = [self.packages.${pkgs.system}.hyprqt6engine pkgs.kdePackages.breeze-icons pkgs.kdePackages.breeze];
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
