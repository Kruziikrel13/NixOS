{
  inputs,
  pkgs,
  self,
  paths,
  ...
}: {
  imports = (paths.scanPaths ./.) ++ [inputs.hyprland.nixosModules.default];
  environment = {
    systemPackages = [
      inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
      self.packages.${pkgs.system}.bibata-hyprcursor
    ];
    pathsToLink = ["/share/icons"];
    variables.NIXOS_OZONE_WL = "1";
  };
  services.gvfs.enable = true;
  xdg.portal.config = {hyprland.default = ["gtk" "hyprland"];};
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    portalPackage =
      inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
  };
}
