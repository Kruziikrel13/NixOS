{paths, ...}: {
  imports = paths.scanPaths ./.;

  programs = {
    agsCustom = {
      enable = false;
      systemd.enable = false;
    };
    quickshell = {
      enable = true;
      systemd.enable = true;
    };
    waybar = {
      enable = false;
      systemd.enable = false;
    };
  };
}
