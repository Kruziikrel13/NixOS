# flake.nix --- nixos system configurations
#
# Author: Michael Petersen <dev@michaelpetersen.io>
# URL:  https://github.com/kruziikrel13/NixOS
#
# Core flake configuration file. Sets up and loads entirety of flake and it's modules.

{
  description = "NixOS Configuration for Kruziikrel13 (Hyprland, Secure-Boot, Gaming)";

  inputs = {
    # NIXPKGS
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-patched.url = "github:kruziikrel13/nixpkgs/nixos-unstable-patched";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    cachyos.url = "github:xddxdd/nix-cachyos-kernel";
    gaming-edge.url = "github:powerofthe69/nix-gaming-edge";
    gaming-edge.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Desktop
    hyprland.url = "github:hyprwm/hyprland?ref=v0.53.1";
    quickshell.url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
    quickshell.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.url = "github:youwen5/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    neovim-nightly-overlay.inputs.nixpkgs.follows = "nixpkgs";
    lanzaboote.url = "github:nix-community/lanzaboote?ref=v1.0.0";
    lanzaboote.inputs.nixpkgs.follows = "nixpkgs";
    nix-gaming.url = "github:fufexan/nix-gaming";
    nix-gaming.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{ self, nixpkgs, ... }:
    let
      forEachSystem =
        fn:
        nixpkgs.lib.genAttrs nixpkgs.lib.platforms.linux (
          system: fn system nixpkgs.legacyPackages.${system}
        );
      args = {
        inherit (nixpkgs) lib;
      };
      lib' = import ./lib args;
    in
    {
      nixosConfigurations = import ./hosts {
        inherit
          self
          nixpkgs
          inputs
          lib'
          ;
      };
      packages = forEachSystem (system: pkgs: import ./packages pkgs);
      formatter = forEachSystem (system: pkgs: pkgs.nixfmt);
    };

}
