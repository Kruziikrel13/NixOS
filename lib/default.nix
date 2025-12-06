{
  self,
  lib,
  pkgs,
  ...
}:
let

  inherit (lib.lists) foldl foldr;
  inherit (lib.attrsets) attrValues;
in
{ }
