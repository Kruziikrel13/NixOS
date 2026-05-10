{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib.modules) mkIf;
  cfg = config.modules.desktop.hyprland;
in
mkIf cfg.enable {
  environment.systemPackages = [ pkgs.hypridle ];
  systemd = {
    packages = [ pkgs.hypridle ];
    user.services.hypridle.wantedBy = [ "graphical-session.target" ];
  };

  environment.etc."xdg/hypr/hypridle.conf".text = ''
    general:lock_cmd = ""
    general:unlock_cmd = ""

    # listener {
    #   timeout = 0 
    #   on-timeout = "loginctl lock-session"
    # }

    listener {
      timeout = 300
      on-timeout = "hyprctl dispatch dpms off"
    }

    listener {
        timeout = 1200
        on-timeout = "systemctl suspend || loginctl suspend"
    }
  '';
}
