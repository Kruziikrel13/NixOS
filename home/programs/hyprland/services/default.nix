{paths, ...}: {
  imports = paths.scanPaths ./.;

  services.hyprpolkitagent.enable = true;
}
