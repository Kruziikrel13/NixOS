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
    environment.sessionVariables.GPG_TTY = "$(tty)";
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
}
