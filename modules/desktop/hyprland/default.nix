{
  config,
  hyprland,
  lib,
  lib',
  ...
}:
let
  cfg = config.modules.desktop.hyprland;

  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;
  inherit (lib'.options) mkOpt mkBoolOpt;

  inherit (lib.types)
    lines
    listOf
    submodule
    int
    str
    ;
in
{
  imports = [ hyprland.nixosModules.default ];
  options.modules.desktop.hyprland = {
    enable = mkEnableOption "hyprland desktop";
    autoLogin = mkEnableOption "auto login";
    extraConfig = mkOpt lines "";
    monitors = mkOpt (listOf (submodule {
      options = {
        output = mkOpt str "";
        mode = mkOpt str "preferred";
        position = mkOpt str "auto";
        scale = mkOpt int 1;
        disable = mkBoolOpt false;
        primary = mkBoolOpt false;
      };
    })) [ { } ];

    idle = {
      time = mkOpt int 600;
      autodpms = mkOpt int 1200;
      autosleep = mkBoolOpt false;
    };
  };

  config = mkIf cfg.enable {
    modules.services.quickshell.enable = true;

    environment.sessionVariables = {
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
      NIXOS_OZONE_WL = "1";
      MOZ_ENABLE_WAYLAND = "1";
    };

    programs.hyprland = {
      enable = true;
      withUWSM = true;
    };

    services.getty = mkIf (cfg.autoLogin && config.programs.hyprland.withUWSM) {
      autologinUser = config.user.name;
      autologinOnce = true;
    };

    security = {
      polkit.enable = true;
      soteria.enable = true;
    };

    environment.loginShellInit = mkIf (cfg.autoLogin && config.programs.hyprland.withUWSM) ''
      if uwsm check may-start; then
          exec uwsm start -eD Hyprland hyprland.desktop
        fi
    '';
  };
}
