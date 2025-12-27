{
  pathLib,
  username,
  ...
}:
{
  home-manager.users.${username} = {
    imports = pathLib.scanPaths ./.;

    programs.git.signing.key = "F34EB44630C65A33";
  };
}
