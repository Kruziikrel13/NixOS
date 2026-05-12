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
  inherit (lib.generators) toLua;
  primary = findFirst (monitor: monitor.primary) { } monitors;

  conf = relativeToRoot "config/hyprland";
in
mkIf cfg.enable {
  environment.etc = {
    "xdg/hypr/hyprland.lua".source = "${conf}/hyprland.lua";
    "xdg/hypr/hyprland/settings".source = "${conf}/hyprland/settings";
    "xdg/hypr/hyprland/rules".source = "${conf}/hyprland/rules";
    "xdg/hypr/hyprland/keybinds".source = "${conf}/hyprland/keybinds";
    "xdg/hypr/hyprland/patches.lua".source = "${conf}/hyprland/patches.lua";
    "xdg/hypr/hyprland/variables.lua".source = pkgs.replaceVars ./variables.lua.in {
      primary = if (primary ? output) then primary.output else "";
      monitors = toLua { } (
        map (mon: {
          inherit (mon)
            output
            mode
            position
            scale
            hdr
            disable
            ;
        }) monitors
      );
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
