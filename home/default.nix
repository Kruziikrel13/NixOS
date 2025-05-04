{
home-manager,
globals,
customLib,
pkgs,
inputs,
...
}: {
  imports = [ home-manager.nixosModules.home-manager ];
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.${globals.user.name} = { config, customLib, ... }: {
    news.display = "show";
    home.username = globals.user.name;
    home.homeDirectory = "/home/${config.home.username}";
    home.preferXdgDirectories = true;
    home.stateVersion = "24.11";
    imports = [ ./hyprland ./nvim.nix ./programs.nix ./shell.nix ];
  };
}
