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
  options.modules.shell.git = with lib.types; {
    enable = mkBoolOpt false;
    lfs.enable = mkBoolOpt false;
    email = mkOpt str "";
    signingKey = mkOpt str "";
  };
  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      lfs.enable = true;
      config = [
        {
          user = {
            inherit (cfg) email signingKey;
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

          github.user = "kruziikrel13";
          gitlab.user = "kruziikrel13";
        }
      ];
    };
  };
}
