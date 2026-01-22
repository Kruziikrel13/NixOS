{
  self,
  config,
  lib,
  ...
}:
{
  programs.nix-ld.enable = true;
  nixpkgs.config.allowUnfree = true;
  environment.variables.NIXPKGS_ALLOW_UNFREE = "1";
  nix =
    let
      filteredInputs = lib.filterAttrs (_: v: v ? outputs) self.inputs;
      nixPathInputs = lib.mapAttrsToList (n: v: "${n}=${v}") filteredInputs;
    in
    {
      nixPath = nixPathInputs ++ [
        "nixpkgs-overlays=${toString self}/overlays"
      ];
      registry = lib.mapAttrs (_: v: { flake = v; }) filteredInputs;
      channel.enable = false;

      settings = {
        auto-optimise-store = true;
        experimental-features = [
          "nix-command"
          "flakes"
        ];

        keep-derivations = true;
        keep-outputs = true;

        trusted-users = [
          "root"
          config.user.name
        ];
        http2 = true;
        warn-dirty = false;
        accept-flake-config = false;

        substituters = [
          "https://cache.nixos.org?priority=10"

          "https://nix-community.cachix.org"
        ];

        trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="

          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        ];
      };
    };

  documentation = {
    nixos.enable = false;
    dev.enable = true;
  };
  system.stateVersion = lib.mkDefault "24.11";
}
