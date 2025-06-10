{pkgs, ...}: {
  hardware = {
    firmware = [ pkgs.linux-firmware ];
    cpu.amd = {
      updateMicrocode = true;
      sev.enable = true;
    };
  };
  services = {
    fwupd.enable = true;
    fstrim.enable = true;
    udisks2.enable = true;
  };
}
