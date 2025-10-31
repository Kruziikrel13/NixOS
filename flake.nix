{
  description = "NixOS Configuration for Kruziikrel13 (Hyprland, Secure-Boot, Gaming)";

  inputs = {
    # NIXPKGS
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-patched.url = "github:kruziikrel13/nixpkgs/nixos-unstable-patched";
    nixpkgs-2022.url = "github:nixos/nixpkgs/22.11";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    chaotic = {
      url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
      inputs.home-manager.follows = "home-manager";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Desktop
    hyprland.url = "github:hyprwm/hyprland";
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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
  };

  outputs =
    inputs@{ self, nixpkgs, ... }:
    let
      forEachSystem =
        fn:
        nixpkgs.lib.genAttrs nixpkgs.lib.platforms.linux (
          system: fn system nixpkgs.legacyPackages.${system}
        );
      modules = import ./modules self inputs;
    in
    {
      inherit (modules) homeManagerModules nixosModules;
      nixosConfigurations = import ./hosts { inherit self nixpkgs inputs; };
      packages = forEachSystem (system: pkgs: import ./packages pkgs);
      formatter = forEachSystem (system: pkgs: pkgs.nixfmt-rfc-style);
    };

}
