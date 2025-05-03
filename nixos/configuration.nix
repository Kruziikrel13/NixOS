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

  system.stateVersion = "24.11";
}
