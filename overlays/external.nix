{
  nixpkgs,
  sentinel,
  hyprland,
  cachyos,
  gaming-edge,
  quickshell,
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
  quickshell.overlays.default
  hyprpwcenter.overlays.default
] final prev)
