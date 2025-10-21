{
  paths,
  pkgs,
  config,
  ...
}:
{
  imports = paths.scanPaths ./.;
  home.shell.enableBashIntegration = true;
  home.packages = with pkgs; [
    grayjay
    pulsemixer
    protonmail-desktop
    via
    playerctl
    spotify

    slack
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
      settings.user = {
        email = "dev@michaelpetersen.io";
        name = config.home.username;
      };
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
