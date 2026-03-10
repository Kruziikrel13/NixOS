{ lib }:
let
  inherit (lib.attrsets)
    filterAttrs
    mapAttrs
    mapAttrs'
    zipAttrsWith
    isAttrs
    ;
  inherit (lib.lists)
    head
    tail
    all
    last
    concatLists
    isList
    ;
in
{
  mapFilterAttrs =
    filter: predicate: attrs:
    filterAttrs predicate (mapAttrs filter attrs);
  mapFilterAttrs' =
    filter: predicate: attrs:
    filterAttrs predicate (mapAttrs' filter attrs);
  filterMapAttrs =
    predicate: filter: attrs:
    (mapAttrs filter (filterAttrs predicate attrs));
  filterMapAttrs' =
    predicate: filter: attrs:
    (mapAttrs' filter (filterAttrs predicate attrs));
  # Unlike //, this will deeply merge attrsets (left > right).
  # mergeAttrs' :: listOf attrs -> attrs
  mergeAttrs' =
    attrList:
    let
      f =
        attrPath:
        zipAttrsWith (
          n: values:
          if (tail values) == [ ] then
            head values
          else if all isList values then
            concatLists values
          else if all isAttrs values then
            f (attrPath ++ [ n ]) values
          else
            last values
        );
    in
    f [ ] attrList;
}
