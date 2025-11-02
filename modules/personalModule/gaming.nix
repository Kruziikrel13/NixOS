self: nix-gaming:
{
  config,
  pkgs,
  lib,
  username,
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
  ];
  options.personalModule.gaming.enable = mkEnableOption "gaming optimizations and tools.";

  config = mkIf cfg.enable {
    users.users.${username}.extraGroups = [ "gamemode" ];
    powerManagement.cpuFreqGovernor = "performance";
    hardware = {
      steam-hardware.enable = true;
      amdgpu.overdrive.ppfeaturemask = "0xffffffff";
    };
    boot = {
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
      };
      steam = {
        enable = true;
        platformOptimizations.enable = true;
        package = pkgs.steam.override {
          extraEnv = {
            PROTON_NO_STEAMINPUT = "1";
            PROTON_ENABLE_HDR = "1";
            ENABLE_HDR_WSI = "1";
            PROTON_ENABLE_WAYLAND = "1";
          };
        };
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
            "--hdr-enabled"
            "--force-grab-cursor"
            "--output-width 3840"
            "--output-height 2160"
            "--backend wayland"
            "--prefer-vk-device 1002:7550" # lspci -nn | grep VGA
          ];
        };
        extraCompatPackages = [
          # pkgs.proton-ge-bin replaced in experimental
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
