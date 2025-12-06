{ lib, ... }:
let
  inherit (lib.options) mkOption;
  inherit (lib.types) listOf str;
in
{
  options.modules.profiles = {
    user = mkOption {
      type = str;
      default = "";
    };
    role = mkOption {
      type = str;
      default = "";
    };
    hardware = mkOption {
      type = listOf str;
      default = [ ];
    };
    networks = mkOption {
      type = listOf str;
      default = [ ];
    };
  };
}
