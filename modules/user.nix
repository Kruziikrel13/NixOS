{ config, lib, pkgs, ... }:

with lib;
let cfg = config.opts.primaryUser; in
  {
  options = with types; {
    opts.primaryUser = {
      username = mkOption {
        type = str;
        default = "usr";
      };
      hashedPassword = mkOption {
        type = nullOr (passwdEntry str);
        default = null;
      };
    };
  };
  config = {
    users.mutableUsers = false;
    users.users = {
      ${cfg.username} = {
        name = cfg.username;
        hashedPassword = cfg.hashedPassword;
        isNormalUser = true;
        group = "users";
        extraGroups = [
          "wheel" "video" "power" "disk" "optical" "storage" "tty"
        ];
      };
    };
  };
}
