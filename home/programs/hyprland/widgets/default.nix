{paths, ... }: {
  imports = paths.scanPaths ./.;

  programs = {
    agsCustom = {
      enable = true;
      systemd.enable = true;
    };
    quickshell = {
      enable = true;
      systemd.enable = false;
    };
    waybar = {
      enable = false;
      systemd.enable = false;
    };
  };
}
