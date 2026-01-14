{
  lib',
  lib,
  ...
}:
let
  inherit (lib'.options) mkOpt;
in
{
  options.modules.profiles = with lib.types; {
    user = mkOpt str "";
    role = mkOpt str "";
    platform = mkOpt str "";
    hardware = mkOpt (listOf str) [ ];
  };
}
