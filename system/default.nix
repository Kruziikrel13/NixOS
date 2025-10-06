{
  paths,
  self,
  username,
  ...
}:
{
  imports = [ self.nixosModules.personalModule ] ++ paths.scanPaths ./.;
  personalModule.username = username;
}
