{
  self,
  lib,
  config,
  pkgs,
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
    user.packages = [ pkgs.zellij ];
    programs.direnv.nix-direnv.enable = true;
    programs.direnv-instant.enable = true;
  };
}
