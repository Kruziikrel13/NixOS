{
  description = ''
    Personal NixOS Configuration for both my main desktop and my laptop
    as a flake.
  '';

  inputs.nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable";
  inputs.home-manager = {
    url = "github:nix-community/home-manager?ref=master";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  inputs.nix-gaming.url = "github:fufexan/nix-gaming";

  inputs.astal = {
    url = "github:aylur/astal";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  inputs.ags = {
    url = "github:aylur/ags";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  inputs.umu = {
    url = "github:Open-Wine-Components/umu-launcher?dir=packaging/nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  inputs.zen-browser = {
    url = "github:youwen5/zen-browser-flake";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, ... } @inputs: let
    inherit (nixpkgs) lib;
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
