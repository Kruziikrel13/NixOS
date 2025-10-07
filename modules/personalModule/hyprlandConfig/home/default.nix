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

  # programs.bash.profileExtra = lib.mkIf osCfg.withUWSM ''
  #   if uwsm check may-start; then
  #     exec uwsm start hyprland-uwsm.desktop
  #   fi
  # '';

  home.packages = with pkgs; [
    wl-clipboard
    wlr-randr
  ];

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
