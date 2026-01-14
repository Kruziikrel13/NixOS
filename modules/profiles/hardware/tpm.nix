{ lib, config, ... }:
let
  inherit (lib) elem;
  inherit (lib.modules) mkIf;
in
mkIf (elem "tpm" config.modules.profiles.hardware) {
  security.tpm2 = {
    enable = true;
    pkcs11.enable = true;
  };
}
