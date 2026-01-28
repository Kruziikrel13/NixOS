{
  lib,
  lib',
  config,
  pkgs,
  ...
}:
let
  inherit (lib'.options) mkBoolOpt;
in
{
  options.modules.desktop.apps.vesktop.enable = mkBoolOpt false;
  config = lib.mkIf config.modules.desktop.apps.vesktop.enable (
    lib.mkMerge [
      (lib.mkIf config.programs.hyprland.enable {
        environment.etc."xdg/hypr/xdph.conf".text = ''
          screencopy {
            allow_token_by_default = true
          }
        '';
      })
      {
        user.packages = [
          (pkgs.vesktop.override {
            withSystemVencord = true;
          })
        ];
      }
    ]
  );
}
