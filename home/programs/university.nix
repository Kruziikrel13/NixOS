{
  pkgs,
  inputs,
  ...
}: let
  pkgs-master = import inputs.nixpkgs-master {
    inherit (pkgs) system;
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "libxml2-2.13.8"
      ];
    };
  };
in {
  programs.obs-studio.enable = true;
  home.packages = [pkgs.slack pkgs-master.unityhub pkgs.jetbrains.rider];
}
