{
  self,
  lib,
  modules,
}:
{
  mkFlake =
    {
      self,
      nixpkgs ? self.inputs.nixpkgs,
      ...
    }@inputs:
    {

    };
}
