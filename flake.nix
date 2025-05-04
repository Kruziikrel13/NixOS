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

  outputs = { self, nixpkgs, home-manager, ... } @inputs: let
    inherit (inputs.nixpkgs) lib;
    globals = import ./globals.nix;
    customLib = import ./lib {inherit lib;};
  in {
    nixosConfigurations = {
      "lethal-devotion" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { 
          inherit inputs;
          inherit globals; 
          inherit home-manager;
          inherit customLib;
        };
        modules = [ 
          ./nixos
          ./home
        ];
      };
    };
  };
}
