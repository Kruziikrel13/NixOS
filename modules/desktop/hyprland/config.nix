{
  self,
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.modules.desktop.hyprland;
  inherit (self.lib) relativeToRoot;
  inherit (lib.modules) mkIf;
  inherit (lib.meta) getExe;
  inherit (cfg) monitors;
  inherit (lib.lists) findFirst;
  primary = (findFirst (monitor: monitor.primary) { } monitors);

  conf = relativeToRoot "config/hypr";
in
mkIf cfg.enable {
  environment.etc = {
    "xdg/hypr/hyprland.lua".source = "${conf}/hyprland.lua";
    "xdg/hypr/hyprland/settings".source = "${conf}/hyprland/settings";
    "xdg/hypr/hyprland/rules".source = "${conf}/hyprland/rules";
    "xdg/hypr/hyprland/keybinds".source = "${conf}/hyprland/keybinds";
    "xdg/hypr/hyprland/patches.lua".source = "${conf}/hyprland/patches.lua";
    "xdg/hypr/hyprland/variables.lua".source = pkgs.replaceVars "${conf}/variables.lua.in" {
      primary = primary.output;
      monitors = ''
        {
               {
                       output = "desc:AOC 24G1WG4 0x0004A33C",
                       mode = "1920x1080@60.0",
                       position = "-1920x345",
               },
               {
                       output = "desc:GIGA-BYTE TECHNOLOGY CO. LTD. AORUS FI32U 21440B000115",
                       mode = "3840x2160@144.00",
                       position = "0x0",
                       hdr = true,
               },
               {
                       output = "desc:ViewSonic Corporation VX2758-C-MH V9M184500179",
                       mode = "1920x1080@144.0",
                       position = "3840x850",
               },
             }
      '';
      runapp = getExe pkgs.runapp;
      terminal = getExe pkgs.ghostty;
      launcher = getExe pkgs.hyprlauncher;
      shutdown = getExe pkgs.hyprshutdown;
      playerctl = getExe pkgs.playerctl;
      wpctl = "${pkgs.wireplumber}/bin/wpctl";
      cursorName = "Bibata-Modern-Classic-Hyprcursor";
      cursorSize = 16;
    };
  };
}
