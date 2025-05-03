{ config, lib, pkgs, home-manager, ... }:
{
  home-manager.useGlobalPkgs = true;
  home-manager.users."kruziikrel13" = { pkgs, ... }: {
    home.stateVersion = "24.11";
    imports = [ ./modules ];
  };
}
