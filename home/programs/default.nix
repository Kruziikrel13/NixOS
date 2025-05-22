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
    pulsemixer
    protonmail-desktop
    via
    inputs.zen-browser.packages.${pkgs.system}.default
    heroic
    obsidian
    playerctl
    spotify
    appflowy
   
    # limo
    # grayjay
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
        tray = false;
        minimizeToTray = false;
        staticTitle = true;
        splashTheming = false;
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
