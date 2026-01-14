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
  options.home = with lib.types; {
    files = mkOpt attrs { };
    configFiles = mkOpt attrs { };
  };

  config = {
    hjem = {
      clobberByDefault = true;
      users.${config.user.name} = {
        directory = config.user.home;
        files = mkAliasDefinitions options.home.files;
        xdg.config.files = mkAliasDefinitions options.home.configFiles;
      };
    };
  };
}
