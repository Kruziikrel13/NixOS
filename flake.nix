{
  description = ''
    Personal NixOS Configuration for both my main desktop and my laptop
    as a flake.
  '';

  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:
    let
      forAllSystems = nixpkgs.lib.genAttrs [ "x86_64-linux" ];
      modules = import ./modules self inputs;
    in
    {
      nixosConfigurations = import ./hosts { inherit self nixpkgs inputs; };
      inherit (modules) homeManagerModules nixosModules;
      packages = forAllSystems (system: import ./packages nixpkgs.legacyPackages.${system});
      templates = import ./templates;
    };
  inputs = {
    # Global / System Inputs
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-2022.url = "github:nixos/nixpkgs?ref=22.11";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Desktop
    hyprland.url = "github:hyprwm/hyprland";
    hyprqt6engine.url = "github:hyprwm/hyprqt6engine";
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Applications
    sherlock = {
      url = "github:Skxxtz/sherlock";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nh.url = "github:nix-community/nh?ref=master";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote?ref=v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    grayjay11.url = "github:kruziikrel13/nixpkgs?ref=grayjay";
    keychron.url = "github:nixos/nixpkgs";
    antec.url = "github:kruziikrel13/nixpkgs?ref=add-antec-flux-pro";
  };
}
