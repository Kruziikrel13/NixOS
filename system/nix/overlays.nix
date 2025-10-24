{ inputs, pkgs, ... }:
let
  dotnet3-available = import inputs.nixpkgs-2022 {
    inherit (pkgs) system;
    config.allowUnfree = true;
  };
  grayjay = import inputs.grayjay11 {
    inherit (pkgs) system;
    config.allowUnfree = true;
  };
  keychron = import inputs.keychron {
    inherit (pkgs) system;
  };
  antec = import inputs.antec {
    inherit (pkgs) system;
  };
in
{
  nixpkgs.overlays = [
    (final: prev: {
      grayjay = grayjay.grayjay.overrideAttrs {
        patches = [ ./versionFix.patch ];
      };
      dotnet-sdk_3 = dotnet3-available.dotnet-sdk_3;
      keychron-udev-rules = keychron.keychron-udev-rules;
      antec-flux-pro = antec.antec-flux-pro;
    })
  ];
}
