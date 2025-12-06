# Striking Distance -- Primary Workstation

rec {
  system = "x86_64-linux";

  modules = {
    profiles = {
      role = "workstation";
      user = "kruziikrel13";
      hardware = [
        "cpu/amd"
        "gpu/amd"
        "gpu/overclock"
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
        extraConfig = ''''; # Any hyprland fixes / edits for this machine
      };
    };
  };

  ## Local config
  config =
    { pkgs, ... }:
    {

    };

  hardware = {
    boot.supportedFilesystems = [
      "btrfs"
      "f2fs"
    ];

    fileSystems = {
      "/boot" = {
        device = "/dev/disk/by-label/BOOT";
        fsType = "vfat";
      };
      "/" = {
        device = "/dev/disk/by-label/NIXOS";
        fsType = "btrfs";
      };
      "/home" = {
        device = "/dev/disk/by-label/NIXOS";
        fsType = "btrfs";
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
      "/home/${modules.profiles.user}/games" = {
        device = "/dev/disk/by-label/GAMES";
        fsType = "f2fs";
        options = [
          "defaults"
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
    };
  };

}
