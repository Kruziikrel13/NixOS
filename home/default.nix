{
specialArgs,
inputs,
username,
paths,
...
}: {
  imports = [ inputs.home-manager.nixosModules.home-manager ];
  environment.pathsToLink = [ "/share/xdg-desktop-portal" "/share/applications" ];
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = ".hm-backup";
    extraSpecialArgs = specialArgs;
    users.${username} = { osConfig, ... }: {
      home.username = username;
      home.homeDirectory = "${osConfig.users.users.${username}.home}";
      home.preferXdgDirectories = true;
      home.stateVersion = "24.11";
      manual = {
        html.enable = false;
        json.enable = false;
        manpages.enable = false;
      };
      imports = paths.scanPaths ./.;
    };
  };
}
