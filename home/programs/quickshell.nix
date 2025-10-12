{
  self,
  pkgs,
  osConfig,
  lib,
  ...
}:
let
  inherit (lib.modules) mkIf;
in
{
  imports = [ self.homeManagerModules.quickshell ];

  config = mkIf osConfig.programs.hyprland.enable {
    programs.quickshell = {
      enable = true;
      systemd.enable = true;
      extraPackages = with pkgs.qt6; [
        qtimageformats
        qtmultimedia
      ];
      config = /etc/nixos/.config/quickshell;
    };

    wayland.windowManager.hyprland = {
      settings = {
        misc = {
          allow_session_lock_restore = true;
          session_lock_xray = true;
          focus_on_activate = true;
        };
        bind = [
          "$mod, E, global, shell:powermenu"
          # "$mod, D, global, shell:launcher"
        ];
        layerrule = [
          "animation slide, shell:bar"
          "animation slide right, shell:powermenu"
          "ignorezero, shell:bar"
          "blur, shell:bar"
          "blur, shell:notifications"
          "ignorealpha 0.1, shell:notifications"
        ];
      };
    };
  };
}
