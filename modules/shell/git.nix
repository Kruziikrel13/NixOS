{
  lib',
  lib,
  config,
  ...
}:
let

  inherit (lib'.options) mkBoolOpt mkOpt;
  cfg = config.modules.shell.git;
in
{
  options.modules.shell.git = {
    enable = mkBoolOpt false;
    lfs.enable = mkBoolOpt false;
    email = mkOpt lib.str "";
    signingKey = mkOpt lib.str "";
  };
  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      config = [
        {
          user = {
            inherit (cfg) email;
            inherit (config.user) name;
          };
          commit = {
            gpgSign = true;
            verbose = true;
          };
          tag.gpgSign = true;
          pull.rebase = true;
          format.signOff = true;
          gpg.format = "openpgp";
        }
      ];
    };
  };
}
