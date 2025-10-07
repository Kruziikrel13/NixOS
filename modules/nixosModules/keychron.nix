self:
{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib.options) mkEnableOption mkOption;
  inherit (lib.types) str;
  inherit (lib.modules) mkIf;
  cfg = config.hardware.keyboard.keychron;
  myPkgs = self.packages.${pkgs.system};
in
{
  options.hardware.keyboard.keychron = {
    enable = mkEnableOption "Enable Keychron keyboard support.";
    idProduct = mkOption {
      type = str;
      description = "USB Product ID for Keychron keyboard.";
    };
  };
  config = mkIf cfg.enable {
    services.udev.packages = [
      (myPkgs.keychron-rules.override {
        idProduct = cfg.idProduct;
      })
    ];
    hardware.keyboard.qmk.enable = true;
    environment.systemPackages = [ pkgs.via ];
  };
}
