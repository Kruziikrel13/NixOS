{
  nixpkgs,
  hyprland,
  cachyos,
  gaming-edge,
  hyprpwcenter,
  hyprshutdown,
  zen-browser,
  ...
}:
final: prev:
{
  inherit (zen-browser.packages.${final.stdenv.hostPlatform.system}) zen-browser-unwrapped;
}
// (nixpkgs.lib.composeManyExtensions [
  hyprland.overlays.default
  cachyos.overlays.default
  gaming-edge.overlays.default
  hyprpwcenter.overlays.default
  hyprshutdown.overlays.default
] final prev)
