{ username, ... }:
{
  users.users.${username} = {
    isNormalUser = true;
    description = "Primary user account for system";
    hashedPassword = "$7$CU..../....kUbGCK9CWgYVn7po7zdyz0$CxvNCDMqGFzOZBAO0iAhytSnonc.LuMyvv1FodplVaB";
    extraGroups = [
      "gamemode"
      "input"
      "audio"
      "networkmanager"
      "transmission"
      "wheel"
      "disk"
      "storage"
    ];
  };
}
