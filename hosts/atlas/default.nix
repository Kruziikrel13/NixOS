{
  pkgs,
  paths,
  ...
}: {
  imports = paths.scanPaths ./.;
  networking.hostName = "atlas";

  services.libinput.enable = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;
}
