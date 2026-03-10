{
  self,
  lib,
  attrs,
  modules,
}:
let
  inherit (lib.modules) mkDefault;
  inherit (lib.attrsets) mapAttrs attrValues filterAttrs;
  inherit (modules) mapModules;
  inherit (attrs) filterMapAttrs mapFilterAttrs mergeAttrs';
in
{
  mapHosts =
    dir:
    mapModules dir (path: {
      inherit path;
      config = import path;
    });
  # Arg 1 is all flake inputs
  # Arg 2 is mkFlake formatted flake definition
  # Return result is proper flake parsed from mkFlake args
  mkFlake =
    {
      # Inputs, deconstruct the main two we need (self and nixpkgs), pass the rest in @inputs
      self,
      nixpkgs ? inputs.nixpkgs,
      ...
    }@inputs:
    {
      # mkFlake args, pass all remaining args in @flake
      devShells ? { },
      hosts ? { },
      packages ? { },
      modules ? { },
      overlays ? { },
      systems,
      ...
    }@flake:
    let
      mkPkgs =
        system: pkgs: overlays:
        import pkgs {
          inherit system overlays;
          config.allowUnfree = true;
        };

      # Generate outputs for each supported system
      perSystem = builtins.map (
        system:
        let
          # Exclude self packages if they don't support the system
          withPkgs =
            pkgs: packageAttrs:
            mapFilterAttrs (
              _: v:
              pkgs.callPackage v (
                {
                  self = self.packages.${system};
                }
                // lib.optionalAttrs (inputs ? zen-browser) {
                  inherit (inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}) zen-browser-unwrapped;
                }
              )
            ) (
              _: v: !(v ? meta.platforms) || (builtins.elem system v.meta.platforms)
            ) packageAttrs;
          pkgs = mkPkgs system nixpkgs (attrValues overlays);
        in
        filterAttrs (_: v: v.${system} != { }) {
          devShells.${system} = withPkgs pkgs devShells;
          packages.${system} = withPkgs pkgs packages;
          formatter.${system} = pkgs.nixfmt-tree;
        }
      ) systems;

      # Generate NixOS Host Configurations. This also implements the custom host spec pattern which can be
      # seen in the host files
      nixosConfigurations = mapAttrs (
        hostName:
        { path, config }:
        let
          nixosModules = filterMapAttrs (_: i: i ? nixosModules) (_: i: i.nixosModules) inputs;
          mkModules = filterMapAttrs (_: i: i ? nixosModules) (_: i: i.nixosModules);
          # Merge modules from all inputs into self, and make referencing own packages easier with self.packages
          mkSelf =
            system:
            self
            // {
              modules = mkModules self.inputs;
              packages = self.packages.${system};
              devShell = self.devShell.${system};
            };
          self' = mkSelf host.system;
          host = config {
            inherit lib nixosModules;
            self = self';
          };
          pkgs = mkPkgs host.system nixpkgs (attrValues overlays);
        in
        nixpkgs.lib.nixosSystem {
          inherit (host) system;
          specialArgs.self = self';
          modules = [
            {
              nixpkgs.pkgs = pkgs;
              networking.hostName = mkDefault hostName;
            }
            ../modules
          ]
          ++ (host.imports or [ ])
          ++ [
            {
              modules = host.modules or { };
            }
          ]
          ++ [
            (host.config or { })
            (host.hardware or { })
          ];
        }
      ) hosts;
    in
    (filterAttrs (
      n: _:
      !builtins.elem n [
        "devShells"
        "hosts"
        "modules"
        "packages"
        "systems"
      ]
    ) flake)
    // {
      inherit nixosConfigurations;
      nixosModules = modules;
    }
    // (mergeAttrs' perSystem);
}
