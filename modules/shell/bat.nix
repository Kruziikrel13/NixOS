{
  lib',
  lib,
  config,
  ...
}:
let
  inherit (lib'.options) mkBoolOpt;
  cfg = config.modules.shell.bat;
  inherit (config.programs.bat) package;
in
{
  options.modules.shell.bat.enable = mkBoolOpt false;
  config = lib.mkIf cfg.enable {
    programs.bat.enable = true;
    environment.shellAliases = {
      ccat = "${lib.modules.getExe package} --plain";
    };
  };
}
