{
  pkgs-patched,
  neovim-nightly-overlay,
  ...
}:
{
  nixpkgs.overlays = [
    (final: prev: {
      inherit (pkgs-patched)
        budget-tracker-tui
        grayjay
        ;
    })
    neovim-nightly-overlay.overlays.default
  ];
}
