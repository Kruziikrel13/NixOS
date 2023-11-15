{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.opts.System;
in {
  options = {
    opts = {
      System = {
        Modules = {
          EnableAudio = mkEnableOption null;
        };
      };
    };
  };

  config = {
    services.xserver = {
      enable = true;
      libinput.enable = true; # Enables TouchPad
      videoDrivers = ["modesetting" "fbdev" "mesa" "amdvlk"];
      modules = with pkgs; [amdvlk mesa];
      excludePackages = [pkgs.xterm];
      displayManager.sddm.enable = true;
    };

    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    systemd.services.seatd = {
      enable = true;
      path = [pkgs.seatd];
      description = "Seat Management Daemon";
      wantedBy = ["multi-user.target"];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.seatd}/bin/seatd -g seat";
        Restart = "always";
        RestartSec = 1;
      };
    };

    users = {
      groups.seat.name = "seat";
      users = {
        ${cfg.Username} = {
          extraGroups = ["seat" "greeter" "polkitd"];
        };
      };
    };

    services.pipewire = mkIf cfg.Modules.EnableAudio {
      enable = true;
      audio.enable = true;
      alsa.enable = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
}
