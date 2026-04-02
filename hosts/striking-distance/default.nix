{ self, ... }:
rec {
  imports = [ self.modules.nixos-hardware.common-cpu-amd-raphael-igpu ];
  system = "x86_64-linux";

  modules = {
    profiles = {
      role = "workstation";
      user = "kruziikrel13";
      hardware = [
        "cpu/amd"
        "gpu/amd"
        "audio"
        "audio/realtime"
        "ssd"
        "secureboot"
        "tpm"
        "peripherals/logitech"
        "peripherals/keychron"
      ];
    };
    uni = {
      slack.enable = true;
      gdevelop.enable = true;
    };
    desktop = {
      hyprland = {
        enable = true;
        autoLogin = true;
        monitors = [
          {
            output = "desc:AOC 24G1WG4 0x0004A33C";
            mode = "1920x1080@144.0";
            position = "-1920x344";
          }
          {
            output = "desc:GIGA-BYTE TECHNOLOGY CO. LTD. AORUS FI32U 21440B000115";
            mode = "3840x2160@144.0";
            position = "0x0";
            hdr = true;
            primary = true;
          }
          {
            output = "desc:ViewSonic Corporation VX2758-C-MH V9M184500179";
            mode = "1920x1080@144.0";
            position = "3840x849";
          }
        ];
        idle = {
          time = 0;
          autodpms = 360;
          autosleep = 520;
        };
      };
      term.default = "ghostty";
      gaming.enable = true;
      browsers.zen.enable = true;
      apps = {
        steam = {
          enable = true;
          gamemode.enable = true;
          gamescope.enable = true;
        };
        obs.enable = true;
        spotify.enable = true;
        minecraft.enable = true;
        grayjay.enable = true;
        heroic.enable = true;
        protonmail.enable = true;
        element.enable = true;
        vesktop.enable = true;
      };
    };
    editors.default = "nvim";
    editors.helix.enable = true;
    shell = {
      defaultSuite = true; # Enables default set of shell progs
      gnupg.enable = true;
      nh.enable = true;
      devenv.enable = true;
      git = {
        enable = true;
        email = "dev@michaelpetersen.io";
        signingKey = "BB10A7F570D54738";
      };
    };
    services = {
      protonvpn = {
        enable = true;
        conf = "/secrets/general.conf";
      };
      antec = {
        enable = true;
        cpu-device = "k10temp-pci-00c3";
        cpu-temp-type = "Tctl";
        gpu-device = "amdgpu-pci-7700";
        gpu-temp-type = "edge";
      };
      hyprlauncher = {
        enable = true;
        windowSize = "900 620";
      };
      hypridle.enable = true;
    };
  };

  config =
    { pkgs, ... }:
    {
      user.packages = with pkgs; [
        mpv
        yt-dlp
      ];
      time.hardwareClockInLocalTime = true;
      # Disable Rhode Microphone as an audio source / output and fix silent audio on startup
      boot.kernelModules = [ "snd-aloop" ];
      services.pipewire.wireplumber.extraConfig."99-rhode-fix"."monitor.alsa.rules" = [
        {
          matches = [ { "node.name" = "alsa_output.usb-R__DE_R__DE_NT-USB__78F16F1B-00"; } ];
          actions.update-props."node.disabled" = true;
        }
      ];
    };

  hardware =
    { ... }:
    {
      # Only applies if audio/realtime is specified
      audio.realtime = {
        quantum = 2048;
        allowedRates = [
          44100
          48000
          88200
          96000
          176400
          352800
          384000
        ];
      };
      fileSystems = {
        "/boot" = {
          device = "/dev/disk/by-uuid/D36D-6804";
          fsType = "vfat";
        };
        "/" = {
          device = "/dev/disk/by-uuid/e2c630af-cf1a-4502-91dc-d69145fb8c61";
          fsType = "btrfs";
        };
        "/home" = {
          device = "/dev/disk/by-uuid/e2c630af-cf1a-4502-91dc-d69145fb8c61";
          fsType = "btrfs";
        };
        "/home/${modules.profiles.user}/games" = {
          device = "/dev/disk/by-uuid/bbdffe39-6de4-46f5-85f6-a08f5c77e355";
          fsType = "f2fs";
          options = [
            "defaults"
            "noauto"
            "nofail"
            "noatime"
            "nodev"
            "exec"
            "x-systemd.automount"

            "compress_algorithm=zstd"
            "compress_chksum"
            "compress_cache"
            "discard"
            "inline_xattr"
            "extent_cache"
          ];
        };
        "/snapshots" = {
          device = "/dev/disk/by-uuid/e2c630af-cf1a-4502-91dc-d69145fb8c61";
          fsType = "btrfs";
          options = [
            "subvol=@snapshots"
            "compress=zstd:6"
            "noexec"
            "nosuid"
            "sync"
          ];
        };
      };
      swapDevices = [ ];

      hardware.enableRedistributableFirmware = true;
    };
}
