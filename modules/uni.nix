{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.slack
    pkgs.gdevelop
    pkgs.winboat
  ];
}
