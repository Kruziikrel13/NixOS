{
  pkgs,
  self,
  inputs,
  lib,
  ...
}: {
  imports = [inputs.hyprland.nixosModules.default];
  options = {
    hyprland = {
      # These are configured at the home manager level, but we define them here
      monitors = lib.mkOption {
        type = lib.types.nullOr (lib.types.listOf lib.types.str);
        default = null;
      };
      workspaces = lib.mkOption {
        type = lib.types.nullOr (lib.types.listOf lib.types.str);
        default = null;
      };
    };
  };
  config = {
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
