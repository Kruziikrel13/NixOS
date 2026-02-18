{
  lib',
  lib,
  config,
  ...
}:
let
  inherit (lib'.options) mkBoolOpt;
  cfg = config.modules.shell.gnupg;
in
{
  options.modules.shell.gnupg.enable = mkBoolOpt false;
  config = lib.mkIf cfg.enable {
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
}
