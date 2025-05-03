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

  outputs = { nixpkgs, home-manager, ... }: let
    globals = import ./globals.nix;
  in {
    nixosConfigurations = {
      "lethal-devotion" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { 
          inherit globals; 
          inherit home-manager;
        };
        modules = [ 
          ./nixos/configuration.nix
          ./home/home.nix
        ];
      };
    };
  };
}
