{
  paths,
  self,
  username,
  inputs,
  ...
}:
{
  imports = [
    self.nixosModules.personalModule
    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
    inputs.nixos-hardware.nixosModules.common-gpu-amd
  ]
  ++ paths.scanPaths ./.;
  personalModule.username = username;
}
