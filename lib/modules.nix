{ lib, attrs }:
with builtins;
rec {
  mapModules =
    dir: fn:
    attrs.mapFilterAttrs' (
      fname: ftype:
      let
        path = "${toString dir}/${fname}";
      in
      if ftype == "directory" && pathExists "${path}/default.nix" then
        lib.nameValuePair fname (fn path)
      else if
        ftype == "regular" && fname != "default.nix" && fname != "flake.nix" && lib.hasSuffix ".nix" fname
      then
        lib.nameValuePair (lib.removeSuffix ".nix" fname) (fn path)
      else
        lib.nameValuePair "" null
    ) (moduleName: moduleResult: moduleResult != null && !(lib.hasPrefix "_" moduleName)) (readDir dir);
  mapModulesRec =
    dir: fn:
    attrs.mapFilterAttrs' (
      fname: ftype:
      let
        path = "${toString dir}/${fname}";
      in
      if ftype == "directory" then
        lib.nameValuePair fname (mapModulesRec path fn)
      else if
        ftype == "regular" && fname != "default.nix" && fname != "flake.nix" && lib.hasSuffix ".nix" fname
      then
        lib.nameValuePair (lib.removeSuffix ".nix" fname) (fn path)
      else
        lib.nameValuePair "" null
    ) (moduleName: moduleResult: moduleResult != null && !(lib.hasPrefix "_" moduleName)) (readDir dir);
  mapModulesRec' =
    dir: fn:
    let
      dirs = lib.mapAttrsToList (key: _: "${dir}/${key}") (
        lib.filterAttrs (
          fname: ftype:
          ftype == "directory" && !(lib.hasPrefix "_" fname) && !(lib.pathExists "${dir}/${fname}/.noload")
        ) (readDir dir)
      );
      files = attrValues (mapModules dir lib.id);
      paths = files ++ concatLists (map (d: mapModulesRec' d lib.id) dirs);
    in
    map fn paths;
}
