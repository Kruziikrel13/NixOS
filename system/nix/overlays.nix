{
  nixpkgs.overlays = [
    (final: prev: {
      mpv-unwrapped = prev.mpv-unwrapped.override {
        libplacebo = let
          version = "7.349.0";
        in prev.libplacebo.overrideAttrs(old: {
            inherit version;
            src = prev.fetchFromGitLab {
              domain = "code.videolan.org";
              owner = "videolan";
              repo = "libplacebo";
              rev = "v${version}";
              hash = "sha256-mIjQvc7SRjE1Orb2BkHK+K1TcRQvzj2oUOCUT4DzIuA=";
            };
          });
      };
    })
  ];
}
