{ lib, config, ... }:
with lib;
mkIf (elem "tpm" config.modules.profiles.hardware) {
  security.tpm2.enable = true;
  security.tpm2.pkcs11.enable = true;
}
