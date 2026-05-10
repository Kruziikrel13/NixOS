{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib.modules) mkIf;
  inherit (lib.meta) getExe;
  cfg = config.modules.desktop.hyprland;
  file = "xdg/hypr/hyprlauncher.conf";
  exe = getExe pkgs.hyprlauncher;
in
mkIf cfg.enable {
  environment.systemPackages = [ pkgs.hyprlauncher ];
  programs.hyprland.settings."$dmenu" = "${exe}";

  environment.etc."${file}".text = ''
    grab_focus = true
    cache:enabled = true
    finders:desktop_launch_prefix = ${getExe pkgs.runapp} --
    ui:window_size = 900 620
  '';

  systemd.user.services.hyprlauncher = {
    unitConfig = {
      Description = "A multipurpose and versatile launcher / picker for Hyprland";
      Documentation = "https://wiki.hypr.land/Hypr-Ecosystem/hyprlauncher/";
      ConditionEnvironment = [ "DISPLAY=:0" ];
    };
    serviceConfig = {
      ExecStart = "${exe} --daemon";
      ExecStop = "${pkgs.coreutils}/bin/kill -TERM $MAINPID";
      Restart = "on-failure";
    };
    wantedBy = [ "graphical-session.target" ];
    restartTriggers = [ config.environment.etc."${file}".source ];
  };
}
