{
  sentinel,
  ...
}:
final: prev:
let
  inherit (final.stdenv.hostPlatform) system;
in
{
  inherit (sentinel.packages.${system}) sentinel;
}
