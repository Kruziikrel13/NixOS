{paths, ... }: {
  imports = paths.scanPaths ./.;

  programs = {
    agsCustom = {
      enable = false;
      systemd.enable = true;
    };
    quickshell = {
      enable = true;
      systemd.enable = true;
    };
  };
}
