{
home-manager,
globals,
customLib,
...
}: {
  imports = [ home-manager.nixosModules.home-manager ];
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit customLib; };
    users.${globals.user.name} = {config, ... }: {
      home.username = globals.user.name;
      home.homeDirectory = "/home/${config.home.username}";
      home.preferXdgDirectories = true;
      home.stateVersion = "24.11";
      imports = customLib.scanPaths ./.;
    };
  };
}
