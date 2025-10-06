self: inputs:
{
  lib,
}:
let
  inherit (lib.options) mkOption;
  inherit (lib.types) str;
in
{
  options.personalModule = {
    username = mkOption {
      type = str;
      description = ''
        Primary system username, for passing to automated home-manager configuration.
      '';
    };
  };
}
