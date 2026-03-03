{
  nixpkgs-patched,
  sentinel,
  hyprland,
  gaming-edge,
  cachyos,
  quickshell,
  hyprpwcenter,
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
      pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
        (python-final: python-prev: {
          picosvg = python-prev.picosvg.overridePythonAttrs (oldAttrs: {
            doCheck = false;
          });
        })
      ];
    })
    sentinel.overlays.default
    hyprland.overlays.default
    cachyos.overlays.pinned
    gaming-edge.overlays.default
    quickshell.overlays.default
    hyprpwcenter.overlays.default
  ];
}
