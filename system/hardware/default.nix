{pkgs, ...}: {
  hardware.firmware = [ pkgs.linux-firmware ];
  services = {
    fwupd.enable = true;
    fstrim.enable = true;
    udisks2.enable = true;
    thermald.enable = true;
  };
}
