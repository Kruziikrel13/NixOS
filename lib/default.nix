{
  lib,
  flakePath ? "/etc/nixos",
}:
rec {
  root = flakePath;
  relativeToRoot = path: "${root}/${path}";
  attrs = import ./attrs.nix { inherit lib; };
  modules = import ./modules.nix { inherit lib attrs; };
  options = import ./options.nix { inherit lib; };
}
