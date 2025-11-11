{
  pkgs-2022,
  pkgs-patched,
  neovim-nightly-overlay,
  ...
}:
{
  nixpkgs.overlays = [
    (final: prev: {
      grayjay = pkgs-patched.grayjay.overrideAttrs {
        patches = [ ./versionFix.patch ];
      };
      inherit (pkgs-2022) dotnet-sdk_3;
      inherit (pkgs-patched) antec-flux-pro runapp;
    })
    neovim-nightly-overlay.overlays.default
  ];
}
