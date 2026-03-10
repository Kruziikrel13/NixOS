args@{ ... }:
{
  nixpkgs.overlays = (import ./patches.nix args) ++ (import ./external.nix args);
}
