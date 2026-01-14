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

      pkgs-patched = import inputs.nixpkgs-patched {
        inherit system;
        config.allowUnfree = true;
      };
    };
in
{
  striking-distance = lib.nixosSystem rec {
    system = "x86_64-linux";
    specialArgs = genSpecialArgs "kruziikrel13" system;
    modules = [
      ./striking_distance
    ]
    ++ (lib'.modules.mapModulesRec' ../modules import);
  };

  aridhol = lib.nixosSystem rec {
    system = "x86_64-linux";
    specialArgs = genSpecialArgs "kruziikrel13" system;
    modules = [
      ./aridhol
    ]
    ++ (lib'.modules.mapModulesRec' ../modules import);
  };
}
