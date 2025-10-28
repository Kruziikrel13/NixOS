{ username, ... }:
let
  coreGroups = [
    "disk"
    "audio"
    "input"
    "storage"
  ];
in
{
  users.users.${username} = {
    isNormalUser = true;
    hashedPassword = "$7$CU..../....kUbGCK9CWgYVn7po7zdyz0$CxvNCDMqGFzOZBAO0iAhytSnonc.LuMyvv1FodplVaB";
    group = "users";
    extraGroups = coreGroups ++ [
      "wheel"
      "networkmanager"
    ];
  };
}
