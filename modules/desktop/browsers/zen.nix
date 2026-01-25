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
  inherit (config.services) glance;

  package = self.packages.${pkgs.stdenv.hostPlatform.system}.zen-custom;
  cfg = config.modules.desktop.browsers.zen;
in
{
  options.modules.desktop.browsers.zen.enable = mkEnableOption "zen browser";
  config = mkIf cfg.enable {
    environment.systemPackages = [
      (package.override {
        useGlance = glance.enable;
        glanceUrl = "${glance.settings.server.host}:${toString glance.settings.server.port}";
      })
    ];
  };
}
