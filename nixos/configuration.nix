{ config, lib, nixpkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./modules/hardware.nix
      ./modules/user.nix
      ./modules/networking.nix
      ./modules/audio.nix
      ./modules/environment.nix
      ./modules/system.nix
      ./modules/gaming.nix
    ];

  opts = {
    audio.enable = true;
    timeZone = "Australia/Brisbane";
  };

  system.stateVersion = "24.11";
}
