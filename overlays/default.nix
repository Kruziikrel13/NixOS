{
  nixpkgs-patched,
  neovim-nightly-overlay,
  hyprland,
  gaming-edge,
  cachyos,
  ...
}:

let
  patched = import nixpkgs-patched {
    system = "x86_64-linux";
    config.allowUnfree = true;
  };
in
{
  nixpkgs.overlays = [
    (final: prev: {
      inherit (patched) antec-flux-pro nitrolaunch;
    })
    neovim-nightly-overlay.overlays.default
    hyprland.overlays.default

    cachyos.overlays.default
    gaming-edge.overlays.default
  ];
}
