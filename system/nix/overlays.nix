{
  pkgs-2022,
  pkgs-patched,
  ...
}:
{
  nixpkgs.overlays = [
    (final: prev: {
      grayjay = pkgs-patched.grayjay.overrideAttrs {
        patches = [ ./versionFix.patch ];
      };
      dotnet-sdk_3 = pkgs-2022.dotnet-sdk_3;
      keychron-udev-rules = pkgs-patched.keychron-udev-rules;
      antec-flux-pro = pkgs-patched.antec-flux-pro;
    })
  ];
}
