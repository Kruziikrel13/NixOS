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
    inputs.quickshell.packages.${pkgs.system}.default
  ];
  qt = {
    enable = true;
    platformTheme.name = "kde";
    style.name = "adwaita-dark";
    style.package = pkgs.adwaita-qt6;
  };
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
