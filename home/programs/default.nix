{
  paths,
  self,
  pkgs,
  config,
  ...
}:
{
  imports = [ self.homeManagerModules.hyprland ] ++ paths.scanPaths ./.;
  home.shell.enableBashIntegration = true;
  home.packages = with pkgs; [
    grayjay
    pulsemixer
    protonmail-desktop
    via
    playerctl
    spotify
    planify

    slack
  ];

  wayland.windowManager.hyprland.settings.exec-once = [
    "uwsm app proton-mail"
  ];

  programs = {
    obsidian.enable = true;
    bash = {
      enable = true;
      enableCompletion = true;
      enableVteIntegration = true;
    };
    direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };
    git = {
      enable = true;
      lfs.enable = true;
      userEmail = "dev@michaelpetersen.io";
      userName = config.home.username;
    };
    gh = {
      enable = true;
      settings.git_protocol = "ssh";
      extensions = [
        pkgs.gh-contribs
        pkgs.gh-notify
      ];
    };
    mpv = {
      enable = true;
      bindings = {
        r = "cycle_values video-rotate 90 180 270 0";
      };
    };
    ghostty = {
      enable = true;
      clearDefaultKeybinds = true;
      settings = {
        theme = "GitHub Dark";
        title = "Ghostty";
      };
    };
    vesktop = {
      enable = true;
      settings = {
        discordBranch = "canary";
        tray = true;
        appBadge = true;
        arRPC = true;
        staticTitle = true;
        splashTheming = false;
        hardwareAcceleration = true;
      };
      vencord = {
        useSystem = true;
        settings = {
          autoUpdate = false;
          useQuickCss = false;
          notifyAboutUpdates = false;
        };
      };
    };
  };
}
