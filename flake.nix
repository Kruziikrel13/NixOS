# flake.nix --- nixos system configurations
#
# Author: Michael Petersen <dev@michaelpetersen.io>
# URL:  https://github.com/kruziikrel13/NixOS
#
# Core flake configuration file. Sets up and loads entirety of flake and it's modules.

{
  description = "NixOS Configuration for Kruziikrel13";

  inputs = {
    # NIXPKGS
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-patched.url = "github:kruziikrel13/nixpkgs/nixos-unstable-patched";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    cachyos.url = "github:xddxdd/nix-cachyos-kernel?ref=release";

    direnv-instant.url = "github:Mic92/direnv-instant";
    gaming-edge = {
      url = "github:powerofthe69/nix-gaming-edge";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Desktop
    hyprland.url = "github:hyprwm/hyprland?ref=main";

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote?ref=v1.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    qtengine = {
      url = "github:kossLAN/qtengine";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ self, nixpkgs, ... }:
    let
      inherit (nixpkgs) lib;
      systems = [ "x86_64-linux" ];
      forEachSystem = fn: lib.genAttrs systems (system: fn system nixpkgs.legacyPackages.${system});
      lib' = import ./lib { inherit lib; };
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
      packages = forEachSystem (
        system: pkgs: {
          zen-custom = pkgs.callPackage ./packages/zen/package.nix {
            inherit (inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}) zen-browser-unwrapped;
          };
          bibata-hyprcursor = pkgs.callPackage ./packages/bibata-hyprcursor { };
        }
      );
      devShells = forEachSystem (
        system: pkgs: {
          default = pkgs.mkShellNoCC {
            shellHook = ''
              export SHELL=${lib.getExe pkgs.bash}
            '';
            packages = with pkgs; [
              nil
              nixd
              statix
              nixfmt
            ];
          };
        }
      );
    };

}
