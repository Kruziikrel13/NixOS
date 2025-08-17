{
  paths,
  self,
  pkgs,
  inputs,
  config,
  ...
}: {
  imports = [self.homeManagerModules.hyprland] ++ paths.scanPaths ./.;
  home.shell.enableBashIntegration = true;
  home.packages = with pkgs; [
    inputs.grayjay.packages.${pkgs.system}.grayjay
    pulsemixer
    protonmail-desktop
    via
    playerctl
    spotify
    planify

    slack
  ];

  wayland.windowManager.hyprland.settings.exec-once = [
    "uwsm app io.github.alainm23.planify"
    "uwsm app slack"
    "uwsm app proton-mail"
  ];

  programs = {
    nix-init.enable = true;
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
      extensions = [pkgs.gh-contribs pkgs.gh-notify];
      settings.git_protocol = "ssh";
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
