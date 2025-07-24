{
  pkgs,
  paths,
  inputs,
  self,
  lib,
  ...
}: let
  inherit (lib) mkForce;
in {
  imports =
    paths.scanPaths ./.
    ++ [
      inputs.nixos-hardware.nixosModules.lenovo-ideapad-slim-5
      self.nixosModules.hyprland
    ];
  networking.hostName = "aridhol";
  services = {
    libinput.enable = true;
    blueman.enable = true;
    # tlp.enable = true;
    thermald.enable = true;
    auto-cpufreq = {
      # enable = true;
      settings = {
        battery = {
          governor = "powersave";
          turbo = "never";
        };
        charger = {
          governor = "performance";
          turbo = "auto";
        };
      };
    };
  };
  boot.kernelPackages = pkgs.linuxPackages_latest;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  services.displayManager.gdm = {
    enable = true;
    wayland = true;
  };

  services.gnome.gnome-browser-connector.enable = true;

  environment.systemPackages = with pkgs; [
    whitesur-cursors
    whitesur-gtk-theme
    whitesur-icon-theme
  ];

  services.desktopManager.gnome.enable = true;

  programs.hyprland = {
    enable = mkForce false;
    monitors = [
      "desc:Chimei Innolux Corporation 0x1553,1920x1080@60.0,0x0,0.9999999999999997,bitdepth,10"
    ];
  };
}
