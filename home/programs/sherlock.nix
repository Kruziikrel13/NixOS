{inputs, ...}: {
  disabledModules = ["${inputs.home-manager}/modules/programs/sherlock.nix"];
  imports = [inputs.sherlock.homeManagerModules.default];
  programs.sherlock = {
    enable = true;
    runAsService = true;
    settings = {
      aliases = {
        vesktop = {
          name = "Discord";
        };
        zen = {
          name = "firefox";
        };
      };
      ignore = ''
        Qt*
        uuctl
        Protontricks
        Neovim*
        Ghostty
        bottom
        Winetricks
        Solaar
      '';
      config = {
        debug.try_suppress_warnings = true;
        backdrop.enable = true;
        caching.enable = true;
        behavior.global_prefix = "uwsm app --";
      };

      launchers = [
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
