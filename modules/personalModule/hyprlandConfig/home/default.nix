{
  config,
  osConfig,
  self,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib.modules) mkIf;
  osCfg = osConfig.programs.hyprland;
  cursor = "Bibata-Modern-Classic-Hyprcursor";
  cursorPackage = self.packages.${pkgs.system}.bibata-hyprcursor;
  genHyprAttrs =
    field: target:
    lib.hm.generators.toHyprconf {
      attrs = {
        ${field} = target;
      };
    };
in
{
  imports = [
    ./workspaces.nix
    ./binds.nix
    ./rules.nix
    ./settings.nix
  ];

  home.packages = with pkgs; [
    wl-clipboard
    wlr-randr
  ];

  home.shellAliases = {
    screenshot = "${pkgs.hyprshot}/bin/hyprshot --mode region --filename";
    screenshot-window = "${pkgs.hyprshot}/bin/hyprshot --mode window --filename";
  };

  xdg.dataFile."icons/${cursor}".source = "${cursorPackage}/share/icons/${cursor}";

  xdg.configFile.hyprlandMonitors = mkIf (osCfg.monitors != null) {
    target = "hypr/monitors.conf";
    text = genHyprAttrs "monitor" osCfg.monitors;
  };
  xdg.configFile.hyprlandWorkspaces = mkIf (osCfg.workspaces != null) {
    target = "hypr/workspaces.conf";
    text = genHyprAttrs "workspace" osCfg.workspaces;
  };
  systemd.user.targets.tray.Unit.Requires = lib.mkForce [ config.wayland.systemd.target ];
}
