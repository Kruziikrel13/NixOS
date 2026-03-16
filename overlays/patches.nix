{ self, ... }:
final: prev:
let
  inherit (final.stdenv.hostPlatform) system;
  nixpkgs = import self.inputs.nixpkgs-patched {
    inherit (final) config;
    inherit system;
  };
in
{
  inherit (nixpkgs) antec-flux-pro grayjay electron_39;
}
