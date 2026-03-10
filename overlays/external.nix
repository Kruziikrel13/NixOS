{
  sentinel,
  hyprland,
  cachyos,
  gaming-edge,
  quickshell,
  hyprpwcenter,
  ...
}:
final: prev:
(final.lib.composeManyExtensions [
  sentinel.overlays.default
  hyprland.overlays.default
  cachyos.overlays.pinned
  gaming-edge.overlays.default
  quickshell.overlays.default
  hyprpwcenter.overlays.default
] final prev)
