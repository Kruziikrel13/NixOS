{
specialArgs,
inputs,
paths,
...
}: {
  imports = [ inputs.hm.nixosModules.default ];
  environment.pathsToLink = [ "/share/xdg-desktop-portal" "/share/applications" ];
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = ".hm-backup";
    extraSpecialArgs = specialArgs;
    users.kruziikrel13 = {config, ... }: {
      home.username = "kruziikrel13";
      home.homeDirectory = "/home/${config.home.username}";
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
