rec {
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
        "tpm"
        "ssd"
        "wifi"
      ];
    };

    desktop = {
      hyprland = {
        enable = true;
        monitors = [
          {
            output = "HDMI-A-1";
            mode = "1920x1080@144";
            position = "";
          }
          {
            output = "DP-2";
            mode = "3840x2160@144";
            position = "0x0";
            primary = true;
          }
          {
            output = "HDMI-A-2";
            mode = "1920x1080@144";
            position = "";
          }
        ];
      };
      browsers = {
        zen.enable = true;
      };
      apps = {
        steam = {
          enable = true;
          gamescope.enable = true;
        };
        grayjay.enable = true;
        minecraft.enable = true;
        heroic.enable = true;
        vesktop.enable = true;
        element.enable = true;
        proton-mail.enable = true;
      };
    };
    editors = {
      default = "nvim";
      nvim.enable = true;
      helix.enable = true;
    };
    services = {
      quickshell.enable = true;
      scx.enable = true;
      ananicy.enable = true;
    };
    dev = {
      sql.enable = true; # Use sqlit for SQL UI (https://github.com/Maxteabag/sqlit)
    };
    shell = {
      rust-core-utils.enable = true;
      git.enable = true;
      gnupg.enable = true;
      bottom.enable = true;
      zoxide.enable = true;
      direnv.enable = true;
      bat = {
        enable = true;
        replace-cat = true;
      };
      eza = {
        enable = true;
        replace-ls = true;
      };
    };
  };

  config =
    { pkgs, ... }:
    {
      user.packages = with pkgs; [
        cachix
        pulsemixer
      ];
    };

  hardware =
    { pkgs, ... }:
    {
      boot.kernelPackages = pkgs.linuxPackages_cachyos;

      services.ratbagd.enable = true;
      hardware = {
        logitech = {
          wireless.enable = true;
          wireless.enableGraphical = true;
        };
        keyboard.qmk = {
          enable = true;
          keychronSupport = true;
        };
        # antec = {
        #   enable = true;
        #   cpu-device = "k10temp-pci-00c3";
        #   cpu-temp-type = "Tctl";
        #   gpu-device = "amdgpu-pci-7700";
        #   gpu-temp-type = "edge";
        # };
      };

      fileSystems = {
        "/boot" = {
          device = "/dev/disk/by-label/BOOT";
          fsType = "vfat";
          options = [
            "ssd"
          ];
        };
        "/" = {
          device = "/dev/disk/by-label/NIXOS";
          fsType = "btrfs";
          options = [
            "ssd"
          ];
        };
        "/home" = {
          device = "/dev/disk/by-label/NIXOS";
          fsType = "btrfs";
          options = [
            "ssd"
          ];
        };
        "/home/${modules.profiles.user}/games" = {
          device = "/dev/disk/by-label/GAMES";
          fsType = "f2fs";
          options = [
            "defaults"
            "ssd"
            "noauto"
            "nofail"
            "noatime"
            "nodev"
            "exec"
            "umask=000"
            "uid=1000"
            "gid=1000"
            "x-systemd.automount"

            # f2fs opts
            "inline_xattr"
            "extent_cache"
          ];
        };
        "/snapshots" = {
          device = "/dev/disk/by-label/NIXOS";
          fsType = "btrfs";
          options = [
            "compress=zstd:6"
            "noexec"
            "nosuid"
            "sync"
            "ssd"
          ];
        };
      };
    };
}
