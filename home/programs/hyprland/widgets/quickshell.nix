{ lib, config, ... }: let
  cfg = config.programs.quickshell;
in {
  options = {
    programs.quickshell = {
      enable = lib.mkEnableOption null;
      systemd.enable = lib.mkEnableOption null;
    };
  };

  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = !config.programs.agsCustom.enable || !config.programs.ags.enable;
        message = "Quickshell widget conflicts with AGS widget. Only enable one.";
      }
    ];
  };
}
