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
  };
}
