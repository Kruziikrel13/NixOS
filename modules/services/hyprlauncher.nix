{
  config,
  lib',
  lib,
  pkgs,
  ...
}:
let

  inherit (lib.modules) mkIf;
  inherit (lib.meta) getExe;
  inherit (lib.options) mkEnableOption;
  inherit (lib'.options) mkOpt;
  cfg = config.modules.services.hyprlauncher;
in
{
  options.modules.services.hyprlauncher = with lib.types; {
    enable = mkEnableOption "hyprlauncher service";
    launchPrefix = mkOpt str "";
    windowSize = mkOpt str "400 260";
  };
  config = mkIf cfg.enable {
    assertions = [
      {
        assertion = config.modules.desktop.hyprland.enable;
        message = "hyprlauncher requires the hyprland desktop";
      }
    ];
    environment.systemPackages = [ pkgs.hyprlauncher ];
    programs.hyprland.settings."$dmenu" = "${getExe pkgs.hyprlauncher}";
    environment.etc."xdg/hypr/hyprlauncher.conf".text = ''
      grab_focus = true
      cache:enabled = true
      finders:desktop_launch_prefix = ${cfg.launchPrefix}
      ui:window_size = ${cfg.windowSize}
    '';
    systemd.user.services.hyprlauncher = {
      unitConfig = {
        Description = "A multipurpose and versatile launcher / picker for Hyprland";
        Documentation = "https://wiki.hypr.land/Hypr-Ecosystem/hyprlauncher/";
        ConditionEnvironment = [ "DISPLAY=:0" ];
      };
      serviceConfig = {
        ExecStart = "${getExe pkgs.hyprlauncher} --daemon";
        Restart = "on-failure";
      };
      wantedBy = [ "graphical-session.target" ];
    };
  };
}
