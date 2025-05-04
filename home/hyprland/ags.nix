{ inputs, 
config,
pkgs,
...}: {
  imports = [ inputs.ags.homeManagerModules.default ];
  home.packages = [ 
    pkgs.gjs 
    inputs.ags.packages.${pkgs.system}.io
    inputs.ags.packages.${pkgs.system}.notifd
  ];

  programs.ags = {
    enable = true;
    configDir = null;

    extraPackages = with inputs.ags.packages.${pkgs.system}; [
      battery
      hyprland
      tray
      wireplumber
      apps
    ];
  };

  # systemd.user.services.ags = {
  #   Unit = {
  #     Description = "Aylur's Gtk Shell";
  #     PartOf = [ 
  #       "tray.target" 
  #       config.wayland.systemd.target
  #     ];
  #     After = [ config.wayland.systemd.target ];
  #   };
  #   Service = {
  #     ExecStart = "${config.programs.ags.package}/bin/ags";
  #     Restart = "on-failure";
  #   };
  #   Install = {
  #     WantedBy = [ config.wayland.systemd.target ];
  #   };
  # };
}
