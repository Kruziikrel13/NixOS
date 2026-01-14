{ lib }:
{
  mkOpt = type: default: lib.mkOption { inherit type default; };
  mkOpt' =
    type: default: desc:
    lib.mkOption { inherit type default desc; };
  mkBoolOpt =
    default:
    lib.mkOption {
      inherit default;
      type = lib.types.bool;
      example = !default;
    };
}
