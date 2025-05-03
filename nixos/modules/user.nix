{ globals, ... }:
{
  users.mutableUsers = false;
  users.users.${globals.user.name} = {
    name = globals.user.name;
    description = "Primary user account for system";
    hashedPassword = globals.user.password;
    isNormalUser = true;
    group = "users";
    extraGroups = [ "wheel" "video" "power" "disk" "optical" "storage" "tty" ];
  };
}
