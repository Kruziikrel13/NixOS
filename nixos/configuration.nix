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
    primaryUser = {
      username = "kruziikrel13";
      hashedPassword = "$y$j9T$jNol.ZCkUDYYlHn5EhnqA0$kRrwM1KZQKRiG8ZPlKcRQNw10cKNOHYGhwyUsdSwNU0";

    };
    networking = {
      hostName = "lethal-devotion";
      ssh.enable = false;
      bluetooth.enable = false;
    };
    gaming = {
      enable = true;
      diskUuid= "4bfedbcc-6059-4ff5-aa86-c5d49ee1a9d0";
    };
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
