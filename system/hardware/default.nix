{ pkgs, ... }:
{
  services = {
    fwupd.enable = true;
    fstrim.enable = true;
    udisks2.enable = true;
  };
}
