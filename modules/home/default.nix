{ config, lib, pkgs, ... }:
{
  imports = [ <home-manager/nixos> ];
  home-manager.useGlobalPkgs = true;
  home-manager.users = {
    ${config.opts.Username} = { ... }: {
      home.stateVersion = "24.11";
      imports = [ ./hyprland ./nvim.nix ./programs.nix ./shell.nix ];
    };
  };
}
