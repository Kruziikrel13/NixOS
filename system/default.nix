{
  pathLib,
  self,
  username,
  nixos-hardware,
  ...
}:
{
  imports = [
    self.nixosModules.personalModule
    nixos-hardware.nixosModules.common-cpu-amd
    nixos-hardware.nixosModules.common-cpu-amd-pstate
    nixos-hardware.nixosModules.common-gpu-amd
  ]
  ++ pathLib.scanPaths ./.;
  personalModule.username = username;
  services.getty = {
    autologinUser = username;
    autologinOnce = true;
  };
}
