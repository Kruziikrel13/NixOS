self: hyprland: home-manager: {
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.types) nullOr listOf str;
  inherit (lib.options) mkOption;

  cfg = config.programs.hyprland;
in {
  imports = [hyprland.nixosModules.default home-manager.nixosModules.default];

  options.programs.hyprland = {
    monitors = mkOption {
      type = nullOr (listOf str);
      default = null;
      description = "List of monitor identifiers for Hyprland.";
    };
    workspaces = mkOption {
      type = nullOr (listOf str);
      default = null;
      description = "List of workspace names for Hyprland.";
    };
  };

  config = mkIf cfg.enable {
    environment = {
      systemPackages = [
        self.packages.${pkgs.system}.bibata-hyprcursor
      ];
      pathsToLink = ["/share/icons"];
      variables.NIXOS_OZONE_WL = "1";
    };
    services.gvfs.enable = true;
    xdg.portal.config = {hyprland.default = ["gtk" "hyprland"];};
    security = {
      polkit.enable = true;
      pam.services.hyprlock = {
        text = "auth include login";
      };
    };

    nix.settings = {
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };
  };
}
