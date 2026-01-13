{
  pkgs-patched,
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
  ];
}
