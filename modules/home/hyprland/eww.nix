{ config, pkgs, lib, ... }:
{
  programs.eww = {
    enable = false;
    enableBashIntegration = true;
  };

  systemd.user.services = lib.mkIf config.programs.eww.enable {
    eww-daemon = {
      Unit = {
        Description = "Eww Daemon";
        PartOf = [ config.wayland.systemd.target ];
      };

      Install = {
        WantedBy = [ config.wayland.systemd.target ];
      };

      Service = {
        Type = "exec";
        ExecStart = "${pkgs.eww}/bin/eww daemon --no-daemonize --force-wayland --restart";
        ExecStop = "${pkgs.eww}/bin/eww kill";
        Restart = "on-failure";
      };
    };
    "eww@bar" = {
      Unit = {
        Description = "Eww";
        Requires = "eww-daemon.service";
        After = "eww-daemon.service";
      };

      Install = {
        WantedBy = [ config.wayland.systemd.target ];
      };

      Service = {
        Type = "oneshot";
        ExecStart = "${pkgs.eww}/bin/eww open --no-daemonize '%i'";
        ExecStop = "${pkgs.eww}/bin/eww close --no-daemonize '%i'";
        RemainAfterExit = "yes";
      };
    };
  };
}
