{
  paths,
  pkgs,
  inputs,
  config,
  ...
}: {
  imports = paths.scanPaths ./.;
  home.shell = {
    enableBashIntegration = true;
    enableNushellIntegration = true;
  };
  home.packages = with pkgs; [
    inputs.zen-browser.packages.${pkgs.system}.default
    inputs.ulauncher.packages.${pkgs.system}.default
    pulsemixer
    protonmail-desktop
    via
    heroic
    obsidian
    playerctl
    spotify

    grayjay
  ];

  systemd.user.services = {
    ulauncher = {
      Unit = {
        Description = "Ulauncher.service";
        Documentation = "https://ulauncher.io";
        PartOf = [ config.wayland.systemd.target ];
        After = [ config.wayland.systemd.target ];
      };

      Service = {
        BusName = "io.ulauncher.Ulauncher";
        Type = "dbus";
        Restart = "always";
        RestartSec = 1;
        ExecStart = "${inputs.ulauncher.packages.${pkgs.system}.default}/bin/ulauncher --daemon";
      };

      Install.WantedBy = [ config.wayland.systemd.target ];
    };
  };

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
      userEmail = "dev@michaelpetersen.io";
      userName = config.home.username;
    };
    gh = {
      enable = true;
      extensions = [ pkgs.gh-contribs pkgs.gh-notify ];
      settings.git_protocol = "ssh";
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
  };
}
