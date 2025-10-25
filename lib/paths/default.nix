lib:
let
  root = "/etc/nixos"; # Has to be string absolute path to flake, or breaks functions
in
{
  relativeToRoot = lib.path.append (/. + root);
  relativeToRootStr = path: "${root}/${path}";
  scanPaths =
    path:
    builtins.map (f: (path + "/${f}")) (
      builtins.attrNames (
        lib.attrsets.filterAttrs (
          name: _type:
          (_type == "directory") # include directories
          && builtins.hasAttr "default.nix" (builtins.readDir (path + "/${name}"))
          || (
            (name != "default.nix") # ignore default.nix
            && (lib.strings.hasSuffix ".nix" name) # include .nix files
          )
        ) (builtins.readDir path)
      )
    );
}
