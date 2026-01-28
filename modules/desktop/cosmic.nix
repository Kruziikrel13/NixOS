{
  config,
  lib,
  lib',
  ...
}:
let
  inherit (lib)
    attrValues
    filter
    length
    ;
  inherit (lib.modules) mkIf mkMerge;
  inherit (lib'.options) mkBoolOpt;
in
{
  options.modules.desktop.cosmic = {
    enable = mkBoolOpt false;
  };

  config = mkIf config.modules.desktop.cosmic.enable (mkMerge [
    {
      assertions = [
        {
          assertion =
            !config.modules.desktop.cosmic.autoLogin
            || (
              length (
                filter (desktop: desktop ? autoLogin && desktop.autoLogin) (attrValues config.modules.desktop)
              ) <= 1
            );
          message = "Only one desktop module can have autoLogin enabled at a time. Niri has autoLogin enabled, but another desktop module also has it enabled.";
        }
      ];
      services.displayManager.cosmic-greeter.enable = true;
      services.desktopManager.cosmic.enable = true;
    }
  ]);
}
