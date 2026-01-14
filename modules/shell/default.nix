{
  lib',
  lib,
  config,
  ...
}:
let
  inherit (lib) mkDefault;
  inherit (lib'.options) mkBoolOpt;
in
{
  options.modules.shell.defaultSuite = mkBoolOpt false;
  config = lib.mkIf config.modules.shell.defaultSuite {
    modules.shell = {
      rust-utils.enable = mkDefault true;
      direnv.enable = mkDefault true;
      zoxide.enable = mkDefault true;
      eza.enable = mkDefault true;
      ripgrep.enable = mkDefault true;
      bat.enable = mkDefault true;
      bottom.enable = mkDefault true;
      fd.enable = mkDefault true;
    };
  };
}
