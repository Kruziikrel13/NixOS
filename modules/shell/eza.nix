{
  lib',
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib'.options) mkBoolOpt;
  cfg = config.modules.shell.eza;
in
{
  options.modules.shell.eza.enable = mkBoolOpt false;
  config = lib.mkIf cfg.enable {
    user.packages = [ pkgs.eza ];
    # TODO: Add Hjem Options
    #
    ##eza = {
    #  enable = true;
    #  icons = "auto";
    #  git = true;
    #  enableBashIntegration = true;
    #  extraOptions = [
    #    "--git-repos"
    #    "--hyperlink"
    #  ];
    #};
  };
}
