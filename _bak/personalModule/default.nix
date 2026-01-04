self: inputs:
{
  lib,
  ...
}:
let
  inherit (lib.options) mkOption;
  inherit (lib.types) str;
in
{
  imports = [
    (import ./hyprlandConfig self inputs.hyprland)
    (import ./gaming.nix self inputs.nix-gaming)
  ];
  options.personalModule = {
    username = mkOption {
      type = str;
      description = ''
        Primary system username, for passing to automated home-manager configuration.
      '';
    };
  };
}
