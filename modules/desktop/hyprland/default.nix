{
  self,
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.desktop.hyprland;

  inherit (lib) mkDefault;
  inherit (self.lib) relativeToRoot;
  inherit (lib.modules) mkIf mkMerge;
  inherit (lib.options) mkEnableOption;
  inherit (self.lib.options) mkOpt;
in
{
  imports = [
    self.modules.hyprland.default
    self.modules.quickshell.default
  ];
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
      modules.services.hyprlauncher.enable = mkDefault true;
      user.packages = with pkgs; [ wl-clipboard ];

      nix.settings = {
        substituters = [ "https://hyprland.cachix.org" ];
        trusted-substituters = [ "https://hyprland.cachix.org" ];
        trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
      };

      environment.sessionVariables = {
        ELECTRON_OZONE_PLATFORM_HINT = "wayland";
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

      programs.quickshell = {
        enable = true;
        systemd.enable = true;
      };

      home.configFiles.quickshell = {
        target = "quickshell";
        source = relativeToRoot "config/quickshell";
      };

      security.polkit.enable = true;
    }
    (mkIf cfg.autoLogin {
      services.getty = {
        autologinUser = config.user.name;
        autologinOnce = true;
      };

      environment.loginShellInit = mkIf config.programs.hyprland.withUWSM ''
        if uwsm check may-start; then
          exec uwsm start hyprland.desktop
        fi
      '';
    })
  ]);
}
