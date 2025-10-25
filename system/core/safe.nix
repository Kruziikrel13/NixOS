{ lib, pkgs, ... }:
{
  specialisation.safe.configuration = {
    system.nixos.tags = lib.mkForce [ "vanilla" ];
    boot.kernelPackages = lib.mkForce pkgs.linuxPackages_latest;
    services.scx.enable = lib.mkForce false;
  };
}
