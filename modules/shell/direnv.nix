{
  self,
  lib,
  config,
  ...
}:
let
  inherit (self.lib.options) mkBoolOpt;
  cfg = config.modules.shell.direnv;
in
{
  imports = [ self.modules.direnv-instant.direnv-instant ];
  options.modules.shell.direnv.enable = mkBoolOpt false;
  config = lib.mkIf cfg.enable {
    programs.direnv-instant.enable = true;
  };
}
