{
  pkgs,
  paths,
  inputs,
  ...
}: {
  imports = paths.scanPaths ./. ++ [
    inputs.nixos-hardware.nixosModules.lenovo-ideapad-slim-5
  ];
  networking.hostName = "aridhol";
  services = {
    libinput.enable = true;
    blueman.enable = true;
    tlp.enable = true;
    thermald.enable = true;
    auto-cpufreq = {
      enable = true;
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
}
