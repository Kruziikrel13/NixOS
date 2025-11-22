{
  hjem,
  username,
  ...
}:
{
  imports = [ hjem.nixosModules.default ];
  hjem.users.${username} = {
    enable = true;
    directory = "/home/${username}";
  };
}
