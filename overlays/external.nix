{
  nixpkgs,
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
  hyprland.overlays.default
  cachyos.overlays.default
  gaming-edge.overlays.default
  hyprpwcenter.overlays.default
] final prev)
