{ 
config,
globals,
inputs,
pkgs,
...
}: if globals.desktop.widgets != "quickshell" then {}
else {
  home.packages = [
    inputs.quickshell.packages.${pkgs.system}.default
    pkgs.jq
  ];

  qt = {
    enable = true;
    platformTheme.name = "adwaita";
    style.name = "adwaita-dark";
  };


  systemd.user.services = {
    quickshell = {
      Unit = {
        Description = "Quickshell Widget Service";
        PartOf = [ config.wayland.systemd.target "tray.target" ];
        After = [ config.wayland.systemd.target ];
        ConditionEnvironment = "WAYLAND_DISPLAY";
      };
      Service = {
        ExecReload = "${pkgs.coreutils}/bin/kill -SIGUSR2 $MAINPID";
        ExecStart = "${inputs.quickshell.packages.${pkgs.system}.default}/bin/quickshell";
        KillMode = "mixed";
        Restart = "on-failure";
      };
      Install = {
        WantedBy = [ config.wayland.systemd.target "tray.target" ];
      };
    };
  };
}
