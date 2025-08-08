{inputs, ...}: {
  disabledModules = ["${inputs.home-manager}/modules/programs/sherlock.nix"];
  imports = [inputs.sherlock.homeManagerModules.default];
  programs.sherlock = {
    enable = true;
    settings = {
      aliases = {
        vesktop = {
          name = "Discord";
        };
      };
      ignore = ''
        Qt*
        uuctl
      '';
      config.debug.try_suppress_warnings = true;
      launchers = [
        {
          name = "Weather";
          type = "weather";
          args = {
            location = "brisbane, australia";
            update_interval = 60;
          };
          home = "OnlyHome";
          priority = 1;
          async = true;
          shortcut = false;
          spawn_focus = false;
        }
        {
          name = "App Launcher";
          type = "app_launcher";
          args = {};
          priority = 2;
          home = "Home";
        }
      ];
    };
  };
  wayland.windowManager.hyprland.settings."$dmenu" = "sherlock";
}
