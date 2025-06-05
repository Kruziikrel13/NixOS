{
  paths,
  lib,
  inputs,
  config,
  ...
}: {
  imports =
    [inputs.lix-module.nixosModules.default]
    ++ (paths.scanPaths ./.);

  # Git explicitly required for flakes
  programs.git.enable = true;

  environment.stub-ld.enable = true;
  nixpkgs.config.allowUnfree = true;
  nix = {
    channel.enable = false;
    # pin the registry to avoid downloading and evaling a new nixpkgs version every time
    registry =
      lib.mapAttrs (_: v: {flake = v;})
      (lib.filterAttrs (_: v: lib.isType "flake" v) inputs);
    # set the path for channels compat
    nixPath =
      lib.mapAttrsToList (key: _: "${key}=flake:${key}") config.nix.registry;

    settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];

      keep-derivations = true;
      keep-outputs = true;

      trusted-users = ["root" "@wheel"];

      warn-dirty = false;
      accept-flake-config = false;
    };
  };
}
