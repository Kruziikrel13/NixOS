{ config, lib, pkgs, ... }:
{
  imports = [ <home-manager/nixos> ];
  home-manager.useGlobalPkgs = true;
  home-manager.users = {
    ${config.opts.Username} = { ... }: {
      home.stateVersion = "24.11";
      programs.bash.enable = true;
      home.shell.enableBashIntegration = true;
      imports = [ ./hyprland.nix ./nvim.nix ./programs.nix ];
    };
  };
}
