{
self,
inputs,
...
}: {
  flake.nixosConfigurations = let
    inherit (inputs.nixpkgs) lib;
    inherit (lib) nixosSystem;

    system = "${self}/system";
    home = "${self}/home";

    specialArgs = { 
      inherit inputs self; 
      paths = import "${self}/lib/paths" lib;
    };
  in {
    striking-distance = nixosSystem {
      inherit specialArgs;
      modules = [
        ./striking_distance
        system
        home
      ];
    };

    # atlas = nixosSystem {
    #   inherit specialArgs;
    #   modules = [
    #     ./atlas
    #     system
    #     home
    #   ];
    # };
  };
}
