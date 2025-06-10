{
  pkgs,
  paths,
  ...
}: {
  imports = paths.scanPaths ./.;
  networking.hostName = "aridhol";
  services = {
    libinput.enable = true;
    blueman.enable = true;
    pulseaudio.enable = true;
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
