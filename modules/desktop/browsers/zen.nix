{
  lib,
  config,
  pkgs,
  self,
  ...
}:
let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;

  package = self.packages.${pkgs.stdenv.hostPlatform.system}.zen-custom;
  cfg = config.modules.desktop.browsers.zen;
in
{
  options.modules.desktop.browsers.zen = {
    enable = mkEnableOption "zen browser";
    homepage.enable = mkEnableOption "custom homepage";
  };
  config = mkIf cfg.enable {
    environment.systemPackages = [ package ];
  };
}
