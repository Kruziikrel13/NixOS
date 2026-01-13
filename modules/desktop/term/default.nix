{
  lib,
  lib',
  config,
  ...
}:
let
  inherit (lib'.options) mkOpt;
  cfg = config.modules.desktop.term;
in
{
  options.modules.desktop.term.default = mkOpt lib.types.str "ghostty";
  config = {
    environment.sessionVariables.TERMINAL = cfg.default;
    programs.ssh.extraConfig = ''
      Host *
        SetEnv TERM=xterm-256color
    '';
  };
}
