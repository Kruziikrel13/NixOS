{
  self,
  nixpkgs,
  inputs,
  ...
}:
let
  inherit (nixpkgs) lib;

  genSpecialArgs =
    username: system:
    inputs
    // {
      inherit self username system;
      pathLib = import ../lib/paths lib;

      pkgs-unstable = import inputs.nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };

      pkgs-stable = import inputs.nixpkgs-stable {
        inherit system;
        config.allowUnfree = true;
      };

      pkgs-2022 = import inputs.nixpkgs-2022 {
        inherit system;
        config.allowUnfree = true;
      };

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
      ../system
      ../home
    ];
  };

  aridhol = lib.nixosSystem rec {
    system = "x86_64-linux";
    specialArgs = genSpecialArgs "kruziikrel13" system;
    modules = [
      ./aridhol
      ../system
      ../home
    ];
  };
}
