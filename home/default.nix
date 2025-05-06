{
home-manager,
globals,
inputs,
customLib,
...
}: {
  imports = [ home-manager.nixosModules.home-manager ];
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "HMmanager";
    extraSpecialArgs = { inherit customLib; inherit globals; inherit inputs; };
    users.${globals.user.name} = {config, ... }: {
      home.username = globals.user.name;
      home.homeDirectory = "/home/${config.home.username}";
      home.preferXdgDirectories = true;
      home.stateVersion = "24.11";
      imports = customLib.scanPaths ./.;
    };
  };
}
