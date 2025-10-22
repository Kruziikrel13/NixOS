{ inputs, pkgs, ... }:
let

  dotnet3-available = import inputs.nixpkgs-2022 {
    inherit (pkgs) system;
    config.allowUnfree = true;
  };
in
{
  nixpkgs.overlays = [
    (final: prev: {
      dotnet-sdk_3 = dotnet3-available.dotnet-sdk_3;
    })
  ];
}
