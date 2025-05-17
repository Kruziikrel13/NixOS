{paths, pkgs, inputs, ...}: {
  imports = paths.scanPaths ./.;

  home.packages = with pkgs; [
    pulsemixer protonmail-desktop via
    inputs.zen-browser.packages.${pkgs.system}.default
    limo heroic obsidian playerctl spotify radeontop
  ];

  programs = {
    nix-init.enable = true;
    zathura.enable = true;
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
        appBadge = true;
        checkUpdates = false;
        tray = true;
        hardwareAcceleration = true;
        discordBranch = "stable";
        splashTheming = true;
        staticTitle = true;
      };
      vencord = {
        useSystem = true;
        settings= {
          autoUpdate = false;
          useQuickCss = false;
          notifyAboutUpdates = false;
        };
      };
    };
    uv.enable = true;
    anyrun = {
      enable = true;
      package = inputs.anyrun.packages.${pkgs.system}.default;
      config = {
        width.fraction = 0.25;
        y.fraction = 0.3;
        hidePluginInfo = true;
        closeOnClick = true;
        layer = "overlay";
        plugins = with inputs.anyrun.packages.${pkgs.system}; [
          applications
          rink
        ];
      };
    };
  };
}
