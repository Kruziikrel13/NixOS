{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./modules/system.nix
      ./modules/gaming.nix
      ./modules/home
    ];

  opts = {
    Username = "kruziikrel13";
    HashedPassword = "$y$j9T$jNol.ZCkUDYYlHn5EhnqA0$kRrwM1KZQKRiG8ZPlKcRQNw10cKNOHYGhwyUsdSwNU0";
    Hostname = "lethal-devotion";
    gaming = {
      enable = true;
      diskUuid= "4bfedbcc-6059-4ff5-aa86-c5d49ee1a9d0";
    };
  };

  system.copySystemConfiguration = true;
  system.stateVersion = "24.11";
}
