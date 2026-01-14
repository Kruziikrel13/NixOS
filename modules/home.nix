{
  hjem,
  config,
  options,
  lib,
  lib',
  ...
}:
let
  inherit (lib'.options) mkOpt;
  inherit (lib.modules) mkAliasDefinitions;
in
{
  imports = [ hjem.nixosModules.default ];
  options = with lib.types; {
    home.files = mkOpt attrs { };
  };

  config = {
    hjem.users.${config.user.name} = {
      directory = config.user.home;
      files = mkAliasDefinitions options.home.files;
    };

  };
}
