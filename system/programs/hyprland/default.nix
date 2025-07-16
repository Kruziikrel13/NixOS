{
  pkgs,
  self,
  paths,
  inputs,
  ...
}: {
  imports = paths.scanPaths ./.;
  environment = {
    systemPackages = [
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
    portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };
}
