{paths, username, ...}: {
  home-manager.users.${username} = {
    imports = paths.scanPaths ./.;
  };
}
