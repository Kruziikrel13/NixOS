self: nix-gaming: chaotic:
{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;
  cfg = config.personalModule.gaming;
in
{
  imports = [
    nix-gaming.nixosModules.platformOptimizations
    chaotic.nixosModules.default
  ];
  options.personalModule.gaming.enable = mkEnableOption "Enable gaming optimizations and tools.";

  config = mkIf cfg.enable {
    powerManagement.cpuFreqGovernor = "performance";
    hardware = {
      steam-hardware.enable = true;
      amdgpu.overdrive.ppfeaturemask = "0xffffffff";
    };
    system.nixos.tags = lib.mkDefault [ "cachyos" ];
    boot = {
      kernelPackages = pkgs.linuxPackages_cachyos;
      kernelParams = [
        "threadirqs"
        "processor.max_cstate=5"
        "idle=nomwait"
        "pcie_aspm=off"
        "usbcore.autosuspend=-1"
      ];
    };
    programs = {
      gamemode = {
        enable = true;
        settings.general = {
          softrealtime = "auto";
          renice = 15;
        };
      };
      gamescope = {
        enable = true;
        capSysNice = true;
      };
      steam = {
        enable = true;
        platformOptimizations.enable = true;
        protontricks.enable = true;
        gamescopeSession = {
          enable = true;
          args = [
            "--rt"
            "--fullscreen"
            "--borderless"
            "--expose-wayland"
            "--grab"
            "--force-grab-cursor"
            "--output-width 3840"
            "--output-height 2160"
            "--backend sdl"
          ];
        };
        extraCompatPackages = [
          pkgs.proton-ge-bin
          pkgs.steamtinkerlaunch
        ];
      };
    };

    home-manager.users.${config.personalModule.username} =
      mkIf config.programs.steam.gamescopeSession.enable
        {
          xdg.desktopEntries.steam-gamescope = {
            name = "Steam (Gamescope)";
            exec = "steam-gamescope %U";
            icon = "steam";
            terminal = false;
            prefersNonDefaultGPU = true;
            noDisplay = false;
            mimeType = [
              "x-scheme-handler/steam"
              "x-scheme-handler/steamlink"
            ];
            categories = [
              "Network"
              "FileTransfer"
              "Game"
            ];
          };
        };
  };
}
