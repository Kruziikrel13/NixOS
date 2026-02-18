{
  config,
  hyprland,
  lib,
  lib',
  pkgs,
  ...
}:
let
  cfg = config.modules.desktop.hyprland;

  inherit (lib)
    mkMerge
    mkDefault
    filter
    length
    attrValues
    ;
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;
  inherit (lib'.options) mkOpt;
in
{
  imports = [ hyprland.nixosModules.default ];
  options.modules.desktop.hyprland = with lib.types; {
    enable = mkEnableOption "hyprland desktop";
    autoLogin = mkEnableOption "auto login";
    extraConfig = mkOpt lines "";
    idle = {
      time = mkOpt int 300;
      autodpms = mkOpt int 600;
      autosleep = mkOpt int 900;
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      assertions = [
        {
          assertion =
            !config.modules.desktop.hyprland.autoLogin
            || (
              length (
                filter (desktop: desktop ? autoLogin && desktop.autoLogin) (attrValues config.modules.desktop)
              ) <= 1
            );
          message = "Only one desktop module can have autoLogin enabled at a time. Hyprland has autoLogin enabled, but another desktop module also has it enabled.";
        }
      ];
      modules.services.quickshell.enable = mkDefault true;
      modules.services.hyprlauncher.enable = mkDefault true;
      user.packages = with pkgs; [
        wl-clipboard
        hyprsysteminfo
      ];

      nix.settings = {
        substituters = [ "https://hyprland.cachix.org" ];
        trusted-substituters = [ "https://hyprland.cachix.org" ];
        trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
      };

      environment.sessionVariables = {
        ELECTRON_OZONE_PLATFORM_HINT = "auto";
        NIXOS_OZONE_WL = "1";
        QT_QPA_PLATFORM = "wayland";
        MOZ_ENABLE_WAYLAND = "1";
      };

      programs.hyprland = {
        enable = true;
        withUWSM = true;
        settings.exec-once = [ "uwsm finalize" ];
        inherit (cfg) extraConfig;
      };

      security = {
        polkit.enable = true;
        soteria.enable = true;
      };

    }
    (mkIf cfg.autoLogin {
      services.getty = {
        autologinUser = config.user.name;
        autologinOnce = true;
      };

      environment.loginShellInit = mkIf config.programs.hyprland.withUWSM ''
        if uwsm check may-start; then
            exec uwsm start -eD Hyprland hyprland.desktop
          fi
      '';
    })
  ]);
}
