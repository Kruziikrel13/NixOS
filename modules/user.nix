{
  lib,
  lib',
  config,
  options,
  ...
}:
let
  inherit (lib'.options) mkOpt;
  inherit (lib.modules) mkAliasDefinitions;
in
{
  options = with lib.types; {
    modules = { };
    user = mkOpt attrs { name = ""; };
  };

  config = {
    user = {
      name = config.modules.profiles.user;
      description = lib.mkDefault "The primary user account";
      extraGroups = [ "wheel" ];
      isNormalUser = true;
      home = "/home/${config.user.name}";
      group = "users";
      uid = 1000;
    };
    users.users.${config.user.name} = mkAliasDefinitions options.user;
  };
}
