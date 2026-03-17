{
  self,
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (self.lib.options) mkBoolOpt;
  inherit (lib.modules) mkIf mkMerge;
  cfg = config.modules.uni;
in
{
  options.modules.uni = {
    winboat.enable = mkBoolOpt false;
    gdevelop.enable = mkBoolOpt false;
    slack.enable = mkBoolOpt false;
  };

  config = mkMerge [
    (mkIf cfg.winboat.enable {
      environment.systemPackages = [ pkgs.winboat ];
      user.extraGroups = [ "docker" ];
      virtualisation.docker.enable = true;
    })

    (mkIf cfg.gdevelop.enable {
      user.packages = [ pkgs.gdevelop ];
    })

    (mkIf cfg.slack.enable {
      user.packages = [ pkgs.slack ];
    })
  ];
}
