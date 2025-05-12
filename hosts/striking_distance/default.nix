{
  paths,
  pkgs,
  ...
}: {
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

      extraPackages = with pkgs; [
        libva
        vaapiVdpau
        libvdpau-va-gl
      ];

      extraPackages32 = with pkgs.pkgsi686Linux; [
        vaapiVdpau
        libvdpau-va-gl
      ];
    };
    cpu.amd = {
      updateMicrocode = true;
      sev.enable = true;
    };
    logitech = {
      wireless.enable = true;
      wireless.enableGraphical = true;
    };
  };
  services.ratbagd.enable = true;
}
