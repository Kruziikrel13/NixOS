{ config, lib, ... }:
let
  # monitors = config.modules.desktop.hyprland.monitors;
  # primaryMonitor = lib.findFirst (monitor: monitor.primary) { } monitors;
  workspaces = builtins.concatLists (
    builtins.genList (
      x:
      let
        ws =
          let
            c = (x + 1) / 10;
          in
          builtins.toString (x + 1 - (c * 10));
      in
      [
        "$mod, ${ws}, workspace, ${toString (x + 1)}"
        "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
      ]
    ) 10
  );
in
{
  programs.hyprland.settings.bind = workspaces;
}
