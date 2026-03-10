{
  self,
  lib,
  config,
  ...
}:
let
  inherit (self.lib.options) mkBoolOpt;
  cfg = config.modules.shell.zoxide;
  inherit (config.programs.zoxide) package;
in
{
  options.modules.shell.zoxide.enable = mkBoolOpt false;
  config = lib.mkIf cfg.enable {
    programs.zoxide.enable = true;
    environment.shellAliases.ccd = "${lib.meta.getExe package}";
  };
}
