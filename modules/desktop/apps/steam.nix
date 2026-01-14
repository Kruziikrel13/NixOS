{
  lib,
  lib',
  config,
  pkgs,
  ...
}:
let
  inherit (lib.modules) mkIf;
  inherit (lib'.options) mkBoolOpt;
  cfg = config.modules.desktop.apps.steam;
in
{
  options.modules.desktop.apps.steam = {
    enable = mkBoolOpt false;
    gamemode.enable = mkBoolOpt false;
    gamescope.enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable (
    lib.mkMerge [
      {
        hardware.steam-hardware.enable = true;
        programs.steam = {
          enable = true;
          protontricks.enable = true;
          package = pkgs.steam.override {
            extraEnv = {
              PROTON_NO_STEAMINPUT = "1";
              PROTON_ENABLE_HDR = "1";
              ENABLE_HDR_WSI = "1";
              PROTON_ENABLE_WAYLAND = "1";
            };
          };
        };
      }

      (mkIf cfg.gamescope.enable {
        programs.gamescope = {
          enable = true;
          capSysNice = true;
        };

        programs.steam.gamescopeSession = {
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
          ];
        };
        user.packages = [
          (pkgs.makeDesktopItem rec {
            name = "launcher-${builtins.hashString "md5" exec}";
            desktopName = "Steam (Gamescope)";
            genericName = "Open steam in gamescope compositor";
            exec = "steam-gamescope %U";
            icon = "steam";
            categories = [
              "Network"
              "FileTransfer"
              "Game"
            ];
          })
        ];
      })

      (mkIf cfg.gamemode.enable {
        user.extraGroups = [ "gamemode" ];
        programs.gamemode = {
          enable = true;
          settings.general = {
            softrealtime = "auto";
            renice = 15;
          };
        };
      })
    ]
  );
}
