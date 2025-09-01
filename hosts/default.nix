{
  self,
  nixpkgs,
  inputs,
  ...
}:
let
  inherit (nixpkgs) lib;
  inherit (lib) nixosSystem;

  system = "${self}/system";
  home = "${self}/home";

  makeSpecialArgs = username: {
    inherit self inputs username;
    paths = import "${self}/lib/paths" lib;
    root = "/etc/nixos";
  };
in
{
  striking-distance = nixosSystem {
    system = "x86_64-linux";
    specialArgs = makeSpecialArgs "kruziikrel13";
    modules = [
      ./striking_distance
      system
      home
    ];
  };

  aridhol = nixosSystem {
    system = "x86_64-linux";
    specialArgs = makeSpecialArgs "kruziikrel13";
    modules = [
      ./aridhol
      system
      home
    ];
  };
}
