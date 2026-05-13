{
  self,
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.desktop.hyprland;

  inherit (self.lib) relativeToRoot;
  inherit (lib.modules) mkIf mkMerge;
  inherit (lib.options) mkEnableOption;
  inherit (self.lib.options) mkOpt mkBoolOpt;
in
{
  imports = [ self.modules.quickshell.default ];
  options.modules.desktop.hyprland = with lib.types; {
    enable = mkEnableOption "hyprland desktop";
    autoLogin = mkEnableOption "auto login";
    monitors =
      with lib.types;
      mkOpt (listOf (submodule {
        options = {
          output = mkOpt str "";
          mode = mkOpt str "preferred";
          position = mkOpt str "auto";
          scale = mkOpt int 1;
          hdr = mkBoolOpt false;
          primary = mkBoolOpt false;
          disable = mkBoolOpt false;
        };
      })) [ { } ];
  };

  config = mkIf cfg.enable (mkMerge [
    {
      programs =
        let
          inherit (pkgs.stdenv.hostPlatform) system;
        in
        {
          hyprland = {
            enable = true;
            withUWSM = true;
            systemd.setPath.enable = true;
            package = self.inputs.hyprland.packages.${system}.hyprland.override { debug = true; };
            portalPackage = self.inputs.hyprland.packages.${system}.xdg-desktop-portal-hyprland;
          };
          quickshell = {
            enable = true;
            systemd.enable = true;
          };
        };
      home.configFiles.quickshell = {
        target = "quickshell";
        source = relativeToRoot "config/quickshell";
      };

      environment = {
        systemPackages = [
          pkgs.wl-clipboard
          self.packages.bibata-hyprcursor
        ];
        sessionVariables = {
          ELECTRON_OZONE_PLATFORM_HINT = "wayland";
          NIXOS_OZONE_WL = "1";
          QT_QPA_PLATFORM = "wayland";
          MOZ_ENABLE_WAYLAND = "1";
          HYPRCURSOR_THEME = "Bibata-Modern-Classic-Hyprcursor";
          HYPRCURSOR_SIZE = "16";
          XCURSOR_SIZE = "16";
        };
      };

      security.polkit.enable = true;
      nix.settings = {
        substituters = [ "https://hyprland.cachix.org" ];
        trusted-substituters = [ "https://hyprland.cachix.org" ];
        trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
      };
    }
    (mkIf cfg.autoLogin {
      services.getty = {
        autologinUser = config.user.name;
        autologinOnce = true;
      };

      environment.loginShellInit = mkIf config.programs.hyprland.withUWSM ''
        if uwsm check may-start; then
          exec uwsm start hyprland.desktop
        fi
      '';
    })
  ]);
}
