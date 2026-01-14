{
  config,
  lib,
  lib',
  ...
}:
let
  inherit (lib)
    mkMerge
    mkDefault
    attrValues
    filter
    length
    ;
  inherit (lib.modules) mkIf;
  inherit (lib'.options) mkBoolOpt;
in
{
  options.modules.desktop.niri = {
    enable = mkBoolOpt false;
    autoLogin = mkBoolOpt false;
  };

  config = mkIf config.modules.desktop.niri.enable (mkMerge [
    {
      assertions = [
        {
          assertion =
            !config.modules.desktop.niri.autoLogin
            || (
              length (
                filter (desktop: desktop ? autoLogin && desktop.autoLogin) (attrValues config.modules.desktop)
              ) <= 1
            );
          message = "Only one desktop module can have autoLogin enabled at a time. Niri has autoLogin enabled, but another desktop module also has it enabled.";
        }
      ];
      programs.niri = {
        enable = true;
        useNautilus = true;
      };
    }

    (mkIf config.modules.desktop.niri.autoLogin {
      programs.uwsm.enable = mkDefault true;
      services.getty = {
        autologinUser = config.user.name;
        autologinOnce = true;
      };

      environment.loginShellInit = mkIf config.programs.uwsm.enable ''
        if uwsm check may-start; then
            exec uwsm start niri.desktop
          fi
      '';
    })
  ]);
}
