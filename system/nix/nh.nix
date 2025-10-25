{
  config,
  pathLib,
  lib,
  nh,
  system,
  ...
}:
let
  inherit (lib.meta) getExe;
  exe = getExe config.programs.nh.package;
in
{
  programs.nh = {
    enable = true;
    package = nh.packages.${system}.default;
    clean = {
      enable = true;
      extraArgs = "--keep 5";
    };
    flake = pathLib.relativeToRootStr ".";
  };

  environment.shellAliases = {
    search = "${exe} search";
    nixos-edit = "cd ${pathLib.relativeToRootStr "."}; nvim; cd -";
    nixos-build = "${exe} os switch";
    nixos-upgrade = "${exe} os switch --update";
    nixos-clean = "${exe} clean all --nogcroots";
  };
}
