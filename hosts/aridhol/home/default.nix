{
  pathLib,
  username,
  ...
}:
{
  home-manager.users.${username} = {
    imports = pathLib.scanPaths ./.;
  };
}
