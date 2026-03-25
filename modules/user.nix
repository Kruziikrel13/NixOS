{
  self,
  lib,
  config,
  options,
  ...
}:
let
  inherit (self.lib.options) mkOpt;
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
      extraGroups = [ "wheel" ];
      isNormalUser = true;
      home = "/home/${config.user.name}";
      group = "users";
      uid = 1000;
    };
    users.users.${config.user.name} = mkAliasDefinitions options.user;
    i18n = {
      defaultLocale = "en_US.UTF-8";
      supportedLocales = [
        "en_US.UTF-8/UTF-8"
        "en_AU.UTF-8/UTF-8"
        "ru_RU.UTF-8/UTF-8"
        "nl_NL.UTF-8/UTF-8"
      ];
    };

    time.timeZone = lib.mkDefault "Australia/Brisbane";
  };
}
