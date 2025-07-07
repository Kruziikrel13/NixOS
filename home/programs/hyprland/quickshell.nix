{
  config,
  inputs,
  pkgs,
  root,
  ...
}: {
  home.packages = with pkgs; [
    qt6.qtimageformats
    qt6.qt5compat
    qt6.qtmultimedia
    qt6.qtdeclarative
    inputs.quickshell.packages.${pkgs.system}.default
  ];
  programs.jq.enable = true;
  xdg.configFile.quickshell = {
    enable = true;
    source = config.lib.file.mkOutOfStoreSymlink "${root}/.config/quickshell";
  };
  systemd.user.services = {
    quickshell = {
      Unit = {
        Description = "Quickshell Desktop Widget";
        PartOf = [config.wayland.systemd.target];
        Requires = [config.wayland.systemd.target];
        After = [config.wayland.systemd.target "tray.target"];
      };

      Service = {
        ExecStart = "${
          inputs.quickshell.packages.${pkgs.system}.default
        }/bin/quickshell";
        Restart = "on-failure";
        KillMode = "mixed";
      };

      Install.WantedBy = [config.wayland.systemd.target];
    };
  };
}
