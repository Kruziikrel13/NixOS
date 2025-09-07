{
  pkgs,
  lib,
  inputs,
  ...
}:
let
  nixpkgs-2022 = import inputs.nixpkgs-2022 {
    inherit (pkgs) system;
    config = {
      allowUnfree = true;
    };
  };
  extra-pkgs = with pkgs; [
    nixpkgs-2022.dotnet-sdk_3
    dotnetCorePackages.sdk_8_0_3xx
    dotnetPackages.Nuget
    mono
    msbuild
  ];
  extra-lib = [ ];
  rider = pkgs.jetbrains.rider.overrideAttrs (attrs: {
    postInstall = (attrs.postInstall or "") + ''
       # Wrap rider with extra tools and libraries
      mv $out/bin/rider $out/bin/.rider-toolless
      makeWrapper $out/bin/.rider-toolless $out/bin/rider \
        --argv0 rider \
        --prefix PATH : "${lib.makeBinPath extra-pkgs}" \
        --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath extra-lib}"
    '';
  });
in
{
  home.packages = [ rider ];
}
