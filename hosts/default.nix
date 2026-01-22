{
  self,
  nixpkgs,
  inputs,
  lib',
  ...
}:
let
  inherit (nixpkgs) lib;

  genSpecialArgs =
    username: system:
    inputs
    // {
      inherit
        self
        username
        system
        lib'
        ;
      pathLib = import ../lib/paths lib;
    };
in
{
  striking-distance = lib.nixosSystem rec {
    system = "x86_64-linux";
    specialArgs = genSpecialArgs "kruziikrel13" system;
    modules = [
      ../overlays
      ./striking_distance
    ]
    ++ (lib'.modules.mapModulesRec' ../modules import);
  };

  aridhol = lib.nixosSystem rec {
    system = "x86_64-linux";
    specialArgs = genSpecialArgs "kruziikrel13" system;
    modules = [
      ../overlays
      ./aridhol
    ]
    ++ (lib'.modules.mapModulesRec' ../modules import);
  };
}
