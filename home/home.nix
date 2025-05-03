
{ home-manager, globals, ... }:
{
  imports = [ home-manager.nixosModules.home-manager ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.${globals.user.name} = { config, ... }: {
    home.username = globals.user.name;
    home.homeDirectory = "/home/${config.home.username}";
    home.stateVersion = "24.11";
    imports = [ ./modules ];
  };
}
