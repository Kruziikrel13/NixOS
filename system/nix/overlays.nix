{ inputs, pkgs, ... }:
let
  grayjay-patch = import inputs.grayjay11 {
    inherit (pkgs) system;
    config.allowUnfree = true;
  };

  dotnet3-available = import inputs.nixpkgs-2022 {
    inherit (pkgs) system;
    config.allowUnfree = true;
  };
in
{
  nixpkgs.overlays = [
    (final: prev: {
      grayjay = grayjay-patch.grayjay.overrideAttrs {
        patches = [ ./versionFix.patch ];
      };
      dotnet-sdk_3 = dotnet3-available.dotnet-sdk_3;
    })
  ];
}
