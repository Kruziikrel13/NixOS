{
  self,
  pkgs,
  ...
}: {
  imports = [self.homeManagerModules.quickshell];

  programs.quickshell = {
    enable = true;
    systemd.enable = true;
    extraPackages = with pkgs.qt6; [qtimageformats qt5compat qtmultimedia];
    config = /etc/nixos/.config/quickshell;
  };

  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.name = "adwaita";
  };
}
