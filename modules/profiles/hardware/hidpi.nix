{ lib, config, ... }:
with lib;
mkIf (elem "hidpi" config.modules.profiles.hardware) {
  environment.variables = {
    QT_DEVICE_PIXEL_RATIO = "2";
    QT_AUTO_SCREEN_SCALE_FACTOR = "true";
  };
}
