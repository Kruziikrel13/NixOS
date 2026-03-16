{
  self,
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (self.lib.options) mkOpt';
  inherit (config.modules.profiles) hardware;
  inherit (lib.modules) mkIf;
  inherit (lib)
    mkMerge
    elem
    any
    hasPrefix
    ;
  cfg = config.audio.realtime;
  qr = "256/48000";
in
{
  # For setting headphone clock rates
  options.audio.realtime = with lib.types; {
    quantum = mkOpt' int 64 "Minimum quantum to set";
    rate = mkOpt' int 48000 "Nominal graph sample rate";
    devicePattern = mkOpt' str "~alsa_output.*" ''
      WirePlumber `node.name` pattern to match devices that should get
      ALSA low-latency overrides.

      Use `pw-dump | grep node.name | grep alsa_output` or
      `wpctl status` followed by `wpctl inspect <id>` to find the right names.
    '';
    allowedRates = mkOpt' (listOf int) [ ] "Sample rates supported by the audio device";
    alsaFormat = mkOpt' str "S32LE" "Alsa Audio Format (S16_LE, S24_3LE, S32LE)";
  };

  config = mkIf (any (s: hasPrefix "audio" s) hardware) (mkMerge [
    {
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };
      user.packages = [
        pkgs.at-spi2-core
      ]
      ++ lib.optionals config.modules.desktop.hyprland.enable [
        pkgs.hyprpwcenter
      ];
      security.rtkit.enable = true;
      user.extraGroups = [ "audio" ];
      services.pulseaudio.enable = lib.mkForce false;
    }
    (mkIf (elem "audio/realtime" hardware) {
      services.pipewire = {
        extraConfig = {
          pipewire."99-lowlatency" = {
            "context.properties" = {
              "default.clock.rate" = 48000;
              "default.clock.quantum" = 1024;
              "default.clock.min-quantum" = 256;
              "default.clock.max-quantum" = cfg.quantum;
              "default.clock.allowed-rates" = cfg.allowedRates;
            };
            "context.modules" = [
              {
                name = "libpipewire-module-rt";
                flags = [
                  "ifexists"
                  "nofail"
                ];
                args = {
                  "nice.level" = -15;
                  "rt.prio" = 88;
                  "rt.time.soft" = 200000;
                  "rt.time.hard" = 200000;
                };
              }
            ];
          };
          pipewire-pulse."99-lowlatency"."pulse.properties" = {
            "server.address" = [ "unix:native" ];
            "pulse.min.req" = qr;
            "pulse.min.quantum" = qr;
            "pulse.min.frag" = qr;
          };

          client."99-lowlatency"."stream.properties" = {
            "node.latency" = qr;
            "resample.quality" = 1;
          };
        };
        wireplumber = {
          enable = true;
          extraConfig = {
            "99-alsa-lowlatency"."monitor.alsa.rules" = [
              {
                matches = [ { "node.name" = cfg.devicePattern; } ];
                actions.update-props = {
                  "audio.format" = cfg.alsaFormat;
                  "audio.rate" = cfg.rate;
                };
              }
            ];
          };
        };
      };

      boot = {
        kernel.sysctl."vm.swappiness" = 10;
        kernelModules = [
          "snd-seq"
          "snd-rawmidi"
        ];
        kernelParams = [ "threadirqs" ];
        postBootCommands = ''
          echo 2048 > /sys/class/rtc/rtc0/max_user_freq
          echo 2048 > /proc/sys/dev/hpet/max-user-freq
          setpci -v -d "*:*" latency_timer=b0
        '';
      };

      security.pam.loginLimits = [
        {
          domain = "@audio";
          item = "memlock";
          type = "-";
          value = "unlimited";
        }
        {
          domain = "@audio";
          item = "rtprio";
          type = "-";
          value = "99";
        }
        {
          domain = "@audio";
          item = "nofile";
          type = "soft";
          value = "999999";
        }
        {
          domain = "@audio";
          item = "nofile";
          type = "hard";
          value = "999999";
        }
      ];

      services.udev.extraRules = ''
        KERNEL=="rtc0", GROUP="audio"
        KERNEL=="hpet", GROUP="audio"
      '';
    })
  ]);
}
