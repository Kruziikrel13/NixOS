{ lib }:
rec {
  attrs = import ./attrs.nix { inherit lib; };
  modules = import ./modules.nix { inherit lib attrs; };
}
