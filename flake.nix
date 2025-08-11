{
  description = ''
    Personal NixOS Configuration for both my main desktop and my laptop
    as a flake.
  '';

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    forAllSystems = nixpkgs.lib.genAttrs ["x86_64-linux"];
    modules = import ./modules self inputs;
  in {
    nixosConfigurations = import ./hosts {inherit self nixpkgs inputs;};
    inherit (modules) homeManagerModules nixosModules;
    packages =
      forAllSystems
      (system: import ./packages nixpkgs.legacyPackages.${system});
    templates = import ./templates;
  };
  inputs = {
    # Global / System Inputs
    systems.url = "github:nix-systems/default-linux";
    nixpkgs.url = "github:nixos/nixpkgs?ref=7fd36ee82c0275fb545775cc5e4d30542899511d";
    nixpkgs-master.url = "github:nixos/nixpkgs?ref=b3b38b1307e86fe09d4bea0639deceb78f52d2b6";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    hyprland.url = "github:hyprwm/Hyprland?ref=v0.50.1";
    grayjay.url = "github:Rishabh5321/grayjay-flake";

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sherlock.url = "github:Skxxtz/sherlock";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      # IMPORTANT: we're using "libgbm" and is only available in unstable so ensure
      # to have it up-to-date or simply don't specify the nixpkgs input
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
