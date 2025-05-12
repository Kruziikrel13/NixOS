{paths, lib, inputs, pkgs, config, ...}: {
  imports = paths.scanPaths ./.;

  # Git explicitly required for flakes
  programs.git.enable = true;

  environment.stub-ld.enable = true;
  nixpkgs.config.allowUnfree = true;
  nix = {
    package = pkgs.lix;

    channel.enable = false;
    # pin the registry to avoid downloading and evaling a new nixpkgs version every time
    registry = lib.mapAttrs (_: v: {flake = v;}) (lib.filterAttrs (_: v: lib.isType "flake" v) inputs);
    # set the path for channels compat
    nixPath = lib.mapAttrsToList (key: _: "${key}=flake:${key}") config.nix.registry;
    
    settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];

      keep-derivations = true;
      keep-outputs = true;

      trusted-users = [ "root" "@wheel" ];

      accept-flake-config = true;
    };
  };
}
