{
  self,
  lib,
  ...
}:
let
  inherit (self.lib.options) mkOpt;
in
{
  options.modules.editors.default = mkOpt lib.types.str "nvim";
}
