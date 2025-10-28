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
  options.personalModule.gaming.enable = mkEnableOption "gaming optimizations and tools.";

  config = mkIf cfg.enable {
    chaotic.mesa-git.enable = true;
    powerManagement.cpuFreqGovernor = "performance";
    hardware = {
      steam-hardware.enable = true;
      amdgpu.overdrive.ppfeaturemask = "0xffffffff";
    };
    system.nixos.tags = lib.mkDefault [ "cachyos" ];
    services.scx.enable = true;
    boot = {
      kernelPackages = pkgs.linuxPackages_cachyos;
      kernelParams = [
        "amd-pstate=active"
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
        package = pkgs.gamescope_git;
      };
      steam = {
        enable = true;
        platformOptimizations.enable = true;
        protontricks.enable = true;
        gamescopeSession = {
          enable = true;
          env = {
            WLR_RENDERER = "vulkan";
            DXVK_HDR = "1";
            ENABLE_GAMESCOPE_WSI = "1";
          };
          args = [
            "--rt"
            "--fullscreen"
            "--borderless"
            "--expose-wayland"
            "--grab"
            "--force-grab-cursor"
            "--output-width 3840"
            "--output-height 2160"
            "--backend wayland"
            "--prefer-vk-device 1002:7550" # lspci -nn | grep VGA
          ];
        };
        extraCompatPackages = [
          pkgs.proton-ge-custom
          pkgs.proton-cachyos
          pkgs.steamtinkerlaunch
          pkgs.luxtorpeda
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
