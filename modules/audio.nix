{ config, lib, pkgs, ... }:

with lib;
let cfg = config.opts.audio; in
  {
  options = with types; {
    opts.audio = {
      enable = mkEnableOption null;
    };
  };
  config = mkIf cfg.enable {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      audio.enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      extraConfig.pipewire = {
        "10-clock-rate" = {
          "context.properties" = {
            "default.clock.rate" = 96000;
            "default.clock.allowed-rates" = [ 44100 48000 96000 ];
          };
        };
      };
      extraConfig.client = {
        "11-resample-max" = {
          "stream.properties" = {
            "resample.quality" = 10;
          };
        };
      };
    };
    users.users = {
      ${config.opts.primaryUser.username} = {
        extraGroups = [ "audio" "pipewire" ];
      };
    };
  };
}
