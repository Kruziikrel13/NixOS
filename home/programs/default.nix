{
  paths,
  pkgs,
  inputs,
  ...
}: {
  imports = paths.scanPaths ./.;
  home.shell = {
    enableBashIntegration = true;
    enableNushellIntegration = true;
  };
  home.packages = with pkgs; [
    inputs.zen-browser.packages.${pkgs.system}.default
    pulsemixer
    protonmail-desktop
    via
    heroic
    obsidian
    playerctl
    spotify

    limo
    grayjay
  ];

  programs = {
    feh.enable = true;
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
      delta.enable = true;
    };
    mpv.enable = true;
    nix-init.enable = true;
    ghostty = {
      enable = true;
      enableBashIntegration = true;
      installBatSyntax = true;
      installVimSyntax = true;
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
    anyrun = {
      enable = true;
      package = inputs.anyrun.packages.${pkgs.system}.default;
      config = {
        width.fraction = 0.25;
        y.fraction = 0.3;
        hidePluginInfo = true;
        closeOnClick = true;
        layer = "overlay";
        plugins = with inputs.anyrun.packages.${pkgs.system}; [applications];
      };
    };
  };
}
