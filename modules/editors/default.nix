{
  lib,
  lib',
  config,
  ...
}:
let
  inherit (lib'.options) mkOpt;
in
{
  options.modules.editors.default = mkOpt lib.types.str "nvim";
}
