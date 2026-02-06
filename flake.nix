# flake.nix --- nixos system configurations
#
# Author: Michael Petersen <dev@michaelpetersen.io>
# URL:  https://github.com/kruziikrel13/NixOS
#
# Core flake configuration file. Sets up and loads entirety of flake and it's modules.

{
  description = "NixOS Configuration for Kruziikrel13";

  inputs = {
    # PKGS
    nixpkgs = {
      type = "github";
      owner = "nixos";
      repo = "nixpkgs";
      ref = "nixos-unstable";
    };

    nixpkgs-patched = {
      type = "github";
      owner = "kruziikrel13";
      repo = "nixpkgs";
      ref = "nixos-unstable-patched";
    };

    # SYSTEM REQUIRED
    nixos-hardware = {
      type = "github";
      owner = "nixos";
      repo = "nixos-hardware";
    };

    hjem = {
      type = "github";
      owner = "feel-co";
      repo = "hjem";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      type = "github";
      owner = "nix-community";
      repo = "lanzaboote";
      ref = "v1.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # GAMING
    cachyos = {
      type = "github";
      owner = "xddxdd";
      repo = "nix-cachyos-kernel";
      ref = "release";
    };

    gaming-edge = {
      type = "github";
      owner = "powerofthe69";
      repo = "nix-gaming-edge";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # DESKTOP
    hyprland = {
      type = "github";
      owner = "hyprwm";
      repo = "hyprland";
      ref = "main";
    };

    qtengine = {
      type = "github";
      owner = "kossLAN";
      repo = "qtengine";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      type = "git";
      url = "https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # APPS
    direnv-instant = {
      type = "github";
      owner = "Mic92";
      repo = "direnv-instant";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      type = "github";
      owner = "youwen5";
      repo = "zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    self.submodules = true;
    sentinel = {
      type = "path";
      path = "config/sentinel.nvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-templates = {
      type = "path";
      path = "config/nix-templates";
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
