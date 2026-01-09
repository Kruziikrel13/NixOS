{
  pkgs-patched,
  neovim-nightly-overlay,
  hyprland,
  cachyos,
  gaming-edge,
  ...
}:
{
  nixpkgs.overlays = [
    (final: prev: {
      inherit (pkgs-patched)
        antec-flux-pro
        budget-tracker-tui
        grayjay
        ;
    })
    neovim-nightly-overlay.overlays.default
    hyprland.overlays.default
    cachyos.overlays.default
    gaming-edge.overlays.default
  ];
}
