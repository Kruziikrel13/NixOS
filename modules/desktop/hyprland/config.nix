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
  fmap = [
    "hyprland.lua"
    "hyprland/patches.lua"
    "hyprland/settings"
    "hyprland/rules"
    "hyprland/keybinds"
  ];
in
mkIf cfg.enable {
  environment.etc =
    builtins.listToAttrs (
      map (f: {
        name = "xdg/hypr/${f}";
        value.source = "${conf}/${f}";
      }) fmap
    )
    // {
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
