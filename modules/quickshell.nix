self: quickshell: home-manager: {
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib.modules) mkIf;
  inherit (lib.meta) getExe;
  inherit (config.lib.file) mkOutOfStoreSymlink;

  inherit (lib.types) nullOr listOf package str path;

  inherit (lib.options) mkOption mkPackageOption mkEnableOption literalExpression;

  quickshellPkgs = quickshell.packages.${pkgs.stdenv.hostPlatform.system};
  cfg = config.programs.quickshell;
in {
  disabledModules = ["${home-manager}/modules/programs/quickshell.nix"];
  options.programs.quickshell = {
    enable = mkEnableOption "quickshell";
    enableDebug = mkEnableOption "Enable debugging for Quickshell";
    supportI3 = mkEnableOption "Enable I3 support for Quickshell";
    supportX11 = mkEnableOption "Enable X11 support for Quickshell";
    package = mkPackageOption quickshellPkgs "quickshell" {nullable = false;};

    extraPackages = mkOption {
      type = listOf package;
      default = [];
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
        default = config.wayland.systemd.target;
        example = "hyprland-session.target";
        description = ''
          The systemd target that will automatically start the quickshell service
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = [cfg.finalPackage];

    xdg.configFile.quickshell = mkIf (cfg.config != null) {
      source = mkOutOfStoreSymlink (toString cfg.config);
    };

    systemd.user.services.quickshell = mkIf cfg.systemd.enable {
      Unit = {
        Description = "Quickshell Desktop Shell System";
        Documentation = "https://quickshell.org";
        PartOf = [
          cfg.systemd.target
          "tray.target"
        ];
        After = [cfg.systemd.target];
        ConditionEnvironment = mkIf (!cfg.supportX11 && !cfg.supportI3) "WAYLAND_DISPLAY";
      };

      Service = {
        ExecStop = "${getExe cfg.finalPackage} kill";
        ExecStart = "${getExe cfg.finalPackage}";
        Restart = "always";
        KillMode = "mixed";
      };

      Install.WantedBy = [cfg.systemd.target "tray.target"];
    };

    programs.quickshell.finalPackage =
      (cfg.package.override {
        debug = cfg.enableDebug;
        withI3 = cfg.supportI3;
        withX11 = cfg.supportX11;
      }).withModules (
        if cfg.extraPackages != []
        then cfg.extraPackages
        else []
      );
  };
}
