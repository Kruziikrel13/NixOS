{paths, ...}: {
  imports = paths.scanPaths ./.;

  networking.hostName = "striking-distance";

  time.hardwareClockInLocalTime = true;

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    logitech = {
      wireless.enable = true;
      wireless.enableGraphical = true;
    };
    keyboard.qmk.enable = true;
  };
  services.ratbagd.enable = true;
}
