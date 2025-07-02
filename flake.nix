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
  in {
    nixosConfigurations = import ./hosts {inherit self nixpkgs inputs;};
    packages =
      forAllSystems
      (system: import ./packages nixpkgs.legacyPackages.${system});
    devShells = forAllSystems (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in
      import ./shell.nix {inherit pkgs;});
    formatter =
      forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
    templates = {
      shell = {
        path = ./templates/shell;
        description = "Minimal Flake Based Developer Shell";
      };
    };
  };
  inputs = {
    # Global / System Inputs
    systems.url = "github:nix-systems/default-linux";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    hyprland.url = "github:hyprwm/Hyprland/9958d297641b5c84dcff93f9039d80a5ad37ab00"; # v0.49.0 Commit Hash

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.93.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    grayjay.url = "github:Rishabh5321/grayjay-flake";
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
