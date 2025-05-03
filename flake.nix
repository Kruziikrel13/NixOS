{
  description = ''
    Personal NixOS Configuration for both my main desktop and my laptop
    as a flake.
  '';
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager?ref=master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... } @inputs: {
    nixosConfigurations = {
      "lethal-devotion" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = inputs;
        modules = [ 
          ./nixos/configuration.nix
          ./home/home.nix
          home-manager.nixosModules.default
        ];
      };
    };
  };
}
