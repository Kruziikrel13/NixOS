{
  inputs,
  pkgs,
  ...
}:
{
  programs.sherlock = {
    enable = true;
    systemd.enable = true;
    package = inputs.sherlock.packages.${pkgs.system}.default;
    settings = {
      config = {
        debug.try_suppress_warnings = true;
        backdrop.enable = true;
        caching.enable = true;
        behavior.global_prefix = "uwsm app --";
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
    launchers = [
      {
        name = "App Launcher";
        type = "app_launcher";
        args = { };
        priority = 2;
        home = "Home";
      }
    ];
  };
  wayland.windowManager.hyprland.settings."$dmenu" = "sherlock";
}
