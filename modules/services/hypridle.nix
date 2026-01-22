{
  lib',
  lib,
  config,
  options,
  pkgs,
  ...
}:
let
  inherit (lib) optionalString mkAliasDefinitions;
  inherit (lib'.options) mkBoolOpt mkOpt;
  cfg = config.modules.services.hypridle;
  hyprCfg = options.modules.desktop.hyprland.idle;
in
{
  options.modules.services.hypridle = with lib.types; {
    enable = mkBoolOpt false;
    # Aliased to modules.desktop.hyprland.idle;
    time = mkOpt int 0;
    autodpms = mkOpt int 0;
    autosleep = mkOpt int 0;
  };
  config = lib.mkIf cfg.enable {
    modules.services.hypridle = {
      time = mkAliasDefinitions hyprCfg.time;
      autodpms = mkAliasDefinitions hyprCfg.autodpms;
      autosleep = mkAliasDefinitions hyprCfg.autosleep;
    };
    assertions = [
      {
        assertion = config.modules.desktop.hyprland.enable;
        message = "hypridle requires the hyprland desktop";
      }
    ];
    environment.systemPackages = [ pkgs.hypridle ];
    systemd = {
      packages = [ pkgs.hypridle ];
      user.services.hypridle.wantedBy = [ "graphical-session.target" ];
    };
    environment.etc."xdg/hypr/hypridle.conf".text = ''
      general:lock_cmd = ""
      general:unlock_cmd = ""
    ''
    + optionalString (cfg.time > 0) ''
      # Lock Session Listener
      listener {
        timeout = ${toString cfg.time}
        on-timeout = "loginctl lock-session"
      }
    ''
    + optionalString (cfg.autodpms > 0) ''
      # DPMS Listener
      listener {
        timeout = ${toString cfg.autodpms}
        on-timeout = "hyprctl dispatch dpms off"
      }
    ''
    + optionalString (cfg.autosleep > 0) ''
      # Sleep Listener
      listener {
        timeout = ${toString cfg.autosleep}
        on-timeout = "systemctl suspend || loginctl suspend"
      }
    '';
  };
}
