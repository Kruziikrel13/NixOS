{
  lib',
  lib,
  config,
  direnv-instant,
  ...
}:
let
  inherit (lib'.options) mkBoolOpt;
  cfg = config.modules.shell.direnv;
in
{
  imports = [ direnv-instant.nixosModules.direnv-instant ];
  options.modules.shell.direnv.enable = mkBoolOpt false;
  config = lib.mkIf cfg.enable {
    programs.direnv-instant.enable = true;
    programs.direnv = {
      enable = true;
      silent = true;
      loadInNixShell = true;
      nix-direnv.enable = true;
    };
  };
}
