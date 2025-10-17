{
  nixpkgs.overlays = [
    (final: prev: {
      # Temporary override until v10 is added to nixpkgs
      grayjay = prev.grayjay.overrideAttrs {
        postUnpack = "rm -f $sourceRoot/prebuilt/.gitattributes";
      };
    })
  ];
}
