{
  pathLib,
  self,
  username,
  nixos-hardware,
  ...
}:
{
  imports = [
    nixos-hardware.nixosModules.common-cpu-amd
    nixos-hardware.nixosModules.common-cpu-amd-pstate
    nixos-hardware.nixosModules.common-gpu-amd
  ]
  ++ pathLib.scanPaths ./.;
  services.getty = {
    autologinUser = username;
    autologinOnce = true;
  };
}
