{
  nixpkgs-patched,
  sentinel,
  hyprland,
  gaming-edge,
  cachyos,
  quickshell,
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
      inherit (patched) antec-flux-pro grayjay smfh;
    })
    sentinel.overlays.default
    hyprland.overlays.default
    cachyos.overlays.pinned
    gaming-edge.overlays.default
    quickshell.overlays.default
  ];
}
