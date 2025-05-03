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
    hardware.supportLogitechMouse = true;
    timeZone = "Australia/Brisbane";
    boot = {
      windows = {
        enable = true;
        efiDeviceHandle = "HD0b";
      };
    };
  };

  system.stateVersion = "24.11";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
