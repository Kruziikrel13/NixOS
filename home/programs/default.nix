{
  pathLib,
  pkgs,
  config,
  ...
}:
{
  imports = pathLib.scanPaths ./.;
  home.shell.enableBashIntegration = true;
  home.packages = with pkgs; [
    grayjay
    pulsemixer
    protonmail-desktop
    via
    playerctl
    spotify
    devenv
  ];

  home.shellAliases = {
    fix-store = "sudo nix-store --verify --check-contents --repair";
  };

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
      silent = true;
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
  };
}
