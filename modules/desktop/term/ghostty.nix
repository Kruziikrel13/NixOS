{
  lib,
  lib',
  config,
  pkgs,
  ...
}:
let
  inherit (lib.modules) mkIf;
  inherit (lib'.options) mkBoolOpt;
  cfg = config.modules.desktop.term;
in
{
  options.modules.desktop.term.ghostty.enable = mkBoolOpt false;
  config = mkIf (cfg.enable or config.modules.desktop.term.default == "ghostty") {
    modules.desktop.term.ghostty.enable = lib.mkDefault true;
    user.packages = [ pkgs.ghostty ];
    # TODO: Add Hjem Module
  };
}
