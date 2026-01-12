{
  lib,
  config,
  pkgs,
  nix-gaming,
  ...
}:
let
  inherit (config.modules.profiles) hardware;
  inherit (lib.modules) mkIf;
  inherit (lib)
    mkMerge
    elem
    any
    hasPrefix
    ;
in
{
  imports = [ nix-gaming.nixosModules.pipewireLowLatency ];
  config = mkIf (any (s: hasPrefix "audio" s) hardware) (mkMerge [
    {
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };
      user.extraGroups = [ "audio" ];
      user.packages = with pkgs; [
        pulsemixer
      ];
    }
    (mkIf (elem "audio/realtime" hardware) {
      security.rtkit.enable = true;
      services.pipewire.lowLatency = {
        enable = true;
        quantum = 64;
        rate = 384000;
      };

      boot = {
        kernel.sysctl."vm.swappiness" = 10;
        kernelModules = [
          "snd-seq"
          "snd-rawmidi"
        ];
        kernelParams = [ "threadirqs" ];
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
