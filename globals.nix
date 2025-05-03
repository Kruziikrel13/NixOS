{
  user = {
    name = "kruziikrel13";
    fullname = "Michael Petersen";
    email = "dev@michaelpetersen.io";
    # `mkpasswd -m scrypt`
    password = "$7$CU..../....kUbGCK9CWgYVn7po7zdyz0$CxvNCDMqGFzOZBAO0iAhytSnonc.LuMyvv1FodplVaB";
  };
  localeinfo = {
    timeZone = "Australia/Brisbane";
    locale = "en_AU.UTF-8";
  };
  networking = {
    # also determines which nixos system configuration from flake.nix will be used
    hostName = "lethal-devotion";
    ssh.enable = false;
    bluetooth.enable = false;
  };
  boot = {
    windows = {
      enable = true;
      efiDeviceHandle = "HD0b";
    };
  };
  desktop.enable = true;
}
