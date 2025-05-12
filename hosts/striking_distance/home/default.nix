{paths, ...}: {
  home-manager.users.kruziikrel13 = {
    imports = paths.scanPaths ./.;
  };
}
