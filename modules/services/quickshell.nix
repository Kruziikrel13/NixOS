{
  config,
  pkgs,
  lib,
  qtengine,
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

  cfg = config.modules.services.quickshell;
in
{
  imports = [ qtengine.nixosModules.default ];
  options.modules.services.quickshell = {
    enable = mkEnableOption "quickshell";
    enableDebug = mkEnableOption "Enable debugging for Quickshell";
    supportI3 = mkEnableOption "Enable I3 support for Quickshell";
    supportX11 = mkEnableOption "Enable X11 support for Quickshell";
    package = mkPackageOption pkgs "quickshell" { nullable = false; };

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
    environment.systemPackages = [
      cfg.finalPackage
      pkgs.kdePackages.breeze
      pkgs.kdePackages.breeze.qt5
      pkgs.kdePackages.breeze-icons
    ];

    home.configFiles."quickshell".source = "/etc/nixos/config/quickshell";

    programs.qtengine = {
      enable = true;
      config = {
        theme = {
          colorScheme = "${pkgs.kdePackages.breeze}/share/color-schemes/BreezeDark.colors";
          iconTheme = "breeze-dark";
          style = "breeze";

          font = {
            family = "NotoSans Nerd Font Propo";
            size = 13;
            weight = -1;
          };

          fontFixed = {
            family = "NotoSans Nerd Font Mono";
            size = 13;
            weight = -1;
          };
        };

        misc = {
          singleClickActivate = false;
          menusHaveIcons = true;
          shortcutsForContextMenus = true;
        };
      };
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
