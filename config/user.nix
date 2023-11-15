{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.opts.System;
in {
  options = {
    opts = {
      System = {
        Username = mkOption {
          type = with types; str;
          default = "usr";
        };
        HashedPassword = mkOption {
          type = with types; nullOr (passwdEntry str);
          default = null;
        };
      };
    };
  };

  config = {
    users.mutableUsers = false;
    users.users = {
      ${cfg.Username} = {
        uid = 1001;
        name = cfg.Username;
        hashedPassword = cfg.HashedPassword;
        isNormalUser = true;
        createHome = true;
        shell = pkgs.zsh;
        group = "users";
        extraGroups = ["wheel" "audio" "video" "power" "disk" "optical" "storage" "tty"];
      };
    };
  };
}
