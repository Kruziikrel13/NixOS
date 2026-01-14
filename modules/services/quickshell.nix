{
  config,
  pkgs,
  lib,
  self,
  quickshell,
  ...
}:
let
  inherit (lib.modules) mkIf;
  inherit (lib.meta) getExe;

  inherit (lib.types)
    nullOr
    listOf
    package
    str
    path
    ;

  inherit (lib.options)
    mkOption
    mkPackageOption
    mkEnableOption
    literalExpression
    ;

  quickshellPkgs = quickshell.packages.${pkgs.stdenv.hostPlatform.system};
  cfg = config.modules.services.quickshell;
in
{
  options.modules.services.quickshell = {
    enable = mkEnableOption "quickshell";
    enableDebug = mkEnableOption "Enable debugging for Quickshell";
    supportI3 = mkEnableOption "Enable I3 support for Quickshell";
    supportX11 = mkEnableOption "Enable X11 support for Quickshell";
    package = mkPackageOption quickshellPkgs "quickshell" { nullable = false; };

    extraPackages = mkOption {
      type = listOf package;
      default = [ ];
      example = literalExpression "[ pkgs.qt5compat ]";
      description = "Extra packages available to Quickshell";
    };

    finalPackage = mkOption {
      type = package;
      readOnly = true;
      description = "Resulting customized Quickshell package";
    };

    config = mkOption {
      type = nullOr path;
      default = null;
      description = ''
        Quickshell configuration to link into the user's home directory
      '';
    };

    systemd = {
      enable = mkEnableOption "Quickshell systemd integration";
      target = mkOption {
        type = str;
        default = "graphical-session.target";
        example = "hyprland-session.target";
        description = ''
          The systemd target that will automatically start the quickshell service
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    assertions = [
      {
        assertion = config.modules.desktop.hyprland.enable;
        message = "quickshell requires the hyprland desktop";
      }
    ];
    environment.systemPackages = [ cfg.finalPackage ];
    home.configFiles."quickshell".source = "${toString self}/config/quickshell";
    qt = {
      enable = true;
      style = "breeze";
      platformTheme = "qt5ct";
    };

    systemd.user.services.quickshell = mkIf cfg.systemd.enable {
      unitConfig = {
        Description = "Quickshell Desktop Shell System";
        Documentation = "https://quickshell.org";
        PartOf = [
          cfg.systemd.target
          "tray.target"
        ];
        After = [ cfg.systemd.target ];
        ConditionEnvironment = mkIf (!cfg.supportX11 && !cfg.supportI3) "WAYLAND_DISPLAY";
      };

      serviceConfig = {
        ExecStop = "${getExe cfg.finalPackage} kill";
        ExecStart = "${getExe cfg.finalPackage}";
        Restart = "always";
        KillMode = "mixed";
      };

      wantedBy = [
        cfg.systemd.target
        "tray.target"
      ];
    };

    modules.services.quickshell.finalPackage =
      (cfg.package.override {
        debug = cfg.enableDebug;
        withI3 = cfg.supportI3;
        withX11 = cfg.supportX11;
      }).withModules
        (if cfg.extraPackages != [ ] then cfg.extraPackages else [ ]);
  };
}
