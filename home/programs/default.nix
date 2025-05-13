{paths, pkgs, inputs, ...}: {
  imports = paths.scanPaths ./.;

  home.packages = with pkgs; [
    walker pulsemixer protonmail-desktop via tomato-c inputs.zen-browser.packages.${pkgs.system}.default
    limo heroic obsidian spotify
  ];
  services.playerctld.enable = true;
  services.udiskie.enable = true;
  services.activitywatch = {
    enable = false;
    package = pkgs.aw-server-rust;
    settings = {
      host = "127.0.0.1";
      port = 5600;
    };
    watchers.aw-watcher = {
      package = pkgs.awatcher;
      executable = "awatcher";
      settings = {
        timeout = 180;
        poll_time = 2;
      };
    };
  };
  programs = {
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
      vencord.useSystem = true;
    };
  };
}
