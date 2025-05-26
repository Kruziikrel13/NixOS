{paths, ...}: {
  imports = paths.scanPaths ./.;

  networking.hostName = "striking-distance";

  time.hardwareClockInLocalTime = true;
  boot = {
    loader.systemd-boot = {
      windows = {
        "10-pro" = {
          title = "Windows 11 Pro";
          efiDeviceHandle = "HD0b";
          sortKey = "a_windows";
        };
      };
    };
  };

  # TODO Verify this is necessary

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    cpu.amd = {
      updateMicrocode = true;
      sev.enable = true;
    };
    logitech = {
      wireless.enable = true;
      wireless.enableGraphical = true;
    };
    keyboard.qmk.enable = true;
  };
  services.ratbagd.enable = true;
}
