{
  lib,
  lib',
  config,
  ...
}:
let
  cfg = config.modules.desktop.hyprland;
  inherit (lib) findFirst optionalString;
  inherit (lib.lists) imap1 flatten;
  inherit (lib'.options) mkOpt mkBoolOpt;
  inherit (cfg) monitors;
  primary_monitor = findFirst (monitor: monitor.primary) { } monitors;
in
{
  options.modules.desktop.hyprland.monitors =
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

  config = {

    programs.hyprland.settings = {
      cursor.default_monitor = primary_monitor.output;
      monitor = builtins.map (
        mon:
        let
          disable = optionalString mon.disable ",disable";
          hdr = optionalString mon.hdr ",bitdepth,10";
        in
        "${mon.output},${mon.mode},${mon.position},${toString mon.scale}" + disable + hdr
      ) monitors;

      # Maps monitors to number keys from left to right (i.e. 1 is leftmost monitor)
      bindp = flatten (
        imap1 (
          i: monitor:
          let
            num = toString i;
          in
          [
            "$mod, ${num}, focusmonitor, ${monitor.output}"
            "$mod SHIFT, ${num}, movewindow, mon:${monitor.output}"
            "$mod SHIFT, ${num}, centerwindow"
          ]
        ) monitors
      );

      # Map workspace defaults to monitors (i.e. workspace 1 is monitor 1)
      workspace = flatten (
        imap1 (
          i: monitor:
          let
            num = toString i;
          in
          "${num},monitor:${monitor.output},default:true"
        ) monitors
      );
    };
  };
}
