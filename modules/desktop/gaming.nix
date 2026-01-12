{
  config,
  lib,
  pkgs,
  gaming-edge,
  cachyos,
  ...
}:
let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption;
  cfg = config.modules.desktop.gaming;
in
{
  imports = [ gaming-edge.nixosModules.default ];
  options.modules.desktop.gaming = {
    enable = mkEnableOption "Enable gaming related modifications";
  };

  config = mkIf cfg.enable {
    nixpkgs.overlays = [
      cachyos.overlays.default
      gaming-edge.overlays.default
    ];
    system.nixos.tags = [ "cachyos" ];
    boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-zen4;

    drivers.mesa-git = {
      enable = true;
      cacheCleanup = {
        enable = false;
        protonPackage = pkgs.proton-cachyos;
      };
    };
    programs.steam.extraCompatPackages = [ pkgs.proton-cachyos ];
    services = {
      scx = {
        enable = true;
        package = pkgs.scx.full;
        scheduler = "scx_lavd";
        extraArgs = [ "--performance" ];
      };
      dbus.implementation = "broker";
      ananicy = {
        enable = true;
        package = pkgs.ananicy-cpp;
        rulesProvider = pkgs.ananicy-rules-cachyos.overrideAttrs (prevAttrs: {
          patches = [
            (pkgs.fetchpatch {
              # Revert removal of compiler rules
              url = "https://github.com/CachyOS/ananicy-rules/commit/5459ed81c0e006547b4f3a3bc40c00d31ad50aa9.patch";
              revert = true;
              hash = "sha256-vc6FDwsAA6p5S6fR1FSdIRC1kCx3wGoeNarG8uEY2xM=";
            })
          ];
        });
      };
    };
  };
}
