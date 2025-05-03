{ globals, lib, ... }: {
  config = lib.mkIf globals.audio.enable {
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
      ${globals.user.name} = {
        extraGroups = [ "audio" "pipewire" ];
      };
    };
  };
}
