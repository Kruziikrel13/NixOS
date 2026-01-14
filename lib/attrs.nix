{ lib }:
with builtins;
{
  mapFilterAttrs =
    filter: predicate: attrs:
    lib.filterAttrs predicate (builtins.mapAttrs filter attrs);
  mapFilterAttrs' =
    filter: predicate: attrs:
    lib.filterAttrs predicate (lib.mapAttrs' filter attrs);
}
