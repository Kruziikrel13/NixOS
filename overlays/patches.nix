{ nixpkgs-patched, ... }:

let
  patched = import nixpkgs-patched {
    system = "x86_64-linux";
    config.allowUnfree = true;
  };
in
[
  (final: prev: {
    inherit (patched) antec-flux-pro grayjay smfh;
    pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
      (python-final: python-prev: {
        picosvg = python-prev.picosvg.overridePythonAttrs (_: {
          doCheck = false;
        });
      })
    ];
  })
]
