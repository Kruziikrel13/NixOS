{
  paths,
  config,
  lib,
  inputs,
  pkgs,
  self,
  ...
}: let
  cursor = "Bibata-Modern-Classic-Hyprcursor";
  cursorPackage = self.packages.${pkgs.system}.bibata-hyprcursor;
in {
  imports = paths.scanPaths ./.;

  home.packages = [inputs.hyprland-contrib.packages.${pkgs.system}.grimblast];
  xdg.dataFile."icons/${cursor}".source = "${cursorPackage}/share/icons/${cursor}";

  programs.bash.profileExtra = ''
    if uwsm check may-start; then
      exec uwsm start hyprland-uwsm.desktop
    fi
  '';
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    systemd.enable = false;
    systemd.variables = ["--all"];
  };

  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland,x11";
    XDG_SESSION_TYPE = "wayland";
  };

  systemd.user.targets.tray.Unit.Requires =
    lib.mkForce [config.wayland.systemd.target];
}
