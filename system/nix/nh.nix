{
  config,
  root,
  lib,
  inputs,
  pkgs,
  ...
}: let
  inherit (lib.meta) getExe;
  inherit (inputs) nh;
  inherit (pkgs) system;
  exe = getExe config.programs.nh.package;
in {
  programs.nh = {
    enable = true;
    package = nh.packages.${system}.default;
    clean = {
      enable = true;
      extraArgs = "--keep 5";
    };
    flake = root;
  };

  environment.shellAliases = {
    nixos-edit = "cd ${root}; nvim; cd -";
    nixos-build = "${exe} os switch";
    nixos-upgrade = "${exe} os switch --update";
    nixos-clean = "${exe} clean all --nogcroots";
  };
}
