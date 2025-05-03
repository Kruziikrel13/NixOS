{ config, lib, pkgs, ... }:
{
  home.stateVersion = "24.11";
  imports = [ ./modules ];
}
