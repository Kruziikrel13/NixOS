{
  config,
  root,
  lib,
  ...
}: let
  inherit (lib.meta) getExe;
  exe = getExe config.programs.nh.package;
in {
  programs.nh = {
    enable = true;
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
