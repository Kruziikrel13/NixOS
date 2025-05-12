{
inputs,
pkgs,
paths,
...
}: {
  imports =  (paths.scanPaths ./.) ++ [ inputs.hyprland.nixosModules.default ];
  environment.systemPackages = [
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
    inputs.self.packages.${pkgs.system}.bibata-hyprcursor
  ];
  environment.pathsToLink= ["/share/icons"];
  xdg.portal.config = {
    hyprland.default = ["gtk" "hyprland"];
  };
   programs.hyprland = {
    enable = true;
    withUWSM = true;
    package = inputs.hyprland.packages.${pkgs.system}.default;
  };

  environment.variables.NIXOS_OZONE_WL = "1";
}
