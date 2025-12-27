{
  pathLib,
  username,
  ...
}:
{
  home-manager.users.${username} = {
    imports = pathLib.scanPaths ./.;
    programs.git.signing.key = "CC4C1D82D045B5DA";
  };
}
