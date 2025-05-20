lib: {
  scanPaths = path:
    builtins.map (f: (path + "/${f}")) (builtins.attrNames
      (lib.attrsets.filterAttrs (name: _type:
        (_type == "directory") # include directories
        && builtins.hasAttr "default.nix" (builtins.readDir (path + "/${name}"))
        || (
          (name != "default.nix") # ignore default.nix
          && (lib.strings.hasSuffix ".nix" name) # include .nix files
        )) (builtins.readDir path)));
}
