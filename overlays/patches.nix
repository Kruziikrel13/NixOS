{ self, ... }:
final: prev:
let
  nixpkgs = import self.inputs.nixpkgs-patched {
    inherit (final) config;
    inherit (final.stdenv.hostPlatform) system;
  };
in
{
  inherit (nixpkgs) antec-flux-pro grayjay;
}
