{
  pkgs-2022,
  pkgs-patched,
  neovim-nightly-overlay,
  ...
}:
{
  nixpkgs.overlays = [
    (final: prev: {
      inherit (pkgs-2022) dotnet-sdk_3;
      inherit (pkgs-patched) antec-flux-pro runapp budget-tracker-tui;
    })
    neovim-nightly-overlay.overlays.default
  ];
}
