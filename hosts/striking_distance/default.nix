{
  username,
  pkgs,
  lib,
  modulesPath,
  nixos-hardware,
  ...
}:
rec {
  networking.hostName = "striking-distance";
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    nixos-hardware.nixosModules.common-cpu-amd
    nixos-hardware.nixosModules.common-cpu-amd-pstate
    nixos-hardware.nixosModules.common-gpu-amd
    nixos-hardware.nixosModules.common-cpu-amd-raphael-igpu
  ];
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  networking.useDHCP = lib.mkDefault true;
  time.hardwareClockInLocalTime = true;
  modules = {
    profiles = {
      user = username;
      role = "workstation";
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
      };
      term.default = "ghostty";
      gaming.enable = true;
      browsers.zen.enable = true;
      apps = {
        steam.enable = true;
        minecraft.enable = true;
        grayjay.enable = true;
        heroic.enable = true;
        proton-mail.enable = true;
        element.enable = true;
        vesktop.enable = true;
      };
    };
    editors = {
      default = "nvim";
      nvim.extraPackages = with pkgs; [
        ## Language Servers
        nil
        nixd
        statix
        deadnix
        copilot-language-server

        lua-language-server
        stylua
        nixfmt
      ];
    };
    editors.helix.enable = true;
    shell = {
      defaultSuite = true; # Enables default set of shell progs
      gnupg.enable = true;
      nh.enable = true;
      git = {
        enable = true;
        email = "dev@michaelpetersen.io";
        signingKey = "F34EB44630C65A33";
      };
    };
    services = {
      quickshell = {
        enable = true;
        systemd.enable = true;
        extraPackages = with pkgs.qt6; [
          qtimageformats
          qtmultimedia
        ];
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
        launchPrefix = "${pkgs.runapp}/bin/runapp --";
        windowSize = "900 620";
      };
      hyprpolkitagent.enable = true;
    };
  };

  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-uuid/D36D-6804";
      fsType = "vfat";
    };
    "/" = {
      device = "/dev/disk/by-uuid/e2c630af-cf1a-4502-91dc-d69145fb8c61";
      fsType = "btrfs";
      options = [ "subvol=@root" ];
    };
    "/home" = {
      device = "/dev/disk/by-uuid/e2c630af-cf1a-4502-91dc-d69145fb8c61";
      fsType = "btrfs";
      options = [ "subvol=@home" ];
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
}
