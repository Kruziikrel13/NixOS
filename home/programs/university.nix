{pkgs, ...}: {
  programs.obs-studio.enable = true;
  home.packages = [pkgs.slack pkgs.unityhub];
}
