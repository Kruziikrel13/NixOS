{
  nixpkgs,
  sentinel,
  hyprland,
  cachyos,
  gaming-edge,
  hyprpwcenter,
  zen-browser,
  ...
}:
final: prev:
{
  inherit (zen-browser.packages.${final.stdenv.hostPlatform.system}) zen-browser-unwrapped;
}
// (nixpkgs.lib.composeManyExtensions [
  sentinel.overlays.default
  hyprland.overlays.default
  cachyos.overlays.pinned
  gaming-edge.overlays.default
  hyprpwcenter.overlays.default
] final prev)
