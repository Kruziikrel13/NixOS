{config, ...}: {
  # systemd.user.services = {
  #   randomize-wallpaper = {
  #     Unit = {
  #       Description = "Randomize Wallpaper";
  #       Requires = "hyprpaper.service";
  #       After = "hyprpaper.service";
  #     };
  #
  #     Service = {
  #       Type = "oneshot";
  #       ExecStart = "${cfg_directory}/scripts/shuffle_wallpapers.sh";
  #     };
  #   };
  # };
  #
  # systemd.user.timers = {
  #   randomize-wallpaper = {
  #     Unit = {Description = "Randomize Wallpaper - Hourly";};
  #
  #     Timer = {
  #       OnCalendar = "hourly";
  #       Persistent = "true";
  #       Unit = "randomize-wallpaper.service";
  #     };
  #
  #     Install = {WantedBy = ["timers.target"];};
  #   };
  # };

  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      preload = [config.xdg.dataFile.wallpaper.target];
      wallpaper = [" , ${config.xdg.dataFile.wallpaper.target}"];
    };
  };
}
