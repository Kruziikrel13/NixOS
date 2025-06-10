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
  };
  boot.kernelPackages = pkgs.linuxPackages_latest;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
}
