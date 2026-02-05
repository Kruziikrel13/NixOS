{
  lib',
  lib,
  config,
  ...
}:
let
  inherit (lib'.options) mkBoolOpt;
  cfg = config.modules.shell.nh;
  exe = lib.meta.getExe config.programs.nh.package;
in
{
  options.modules.shell.nh.enable = mkBoolOpt false;
  config = lib.mkIf cfg.enable {
    programs.nh = {
      enable = true;
      flake = lib'.root;
    };

    environment.shellAliases = {
      search = "${exe} search";
      nixos-edit = "cd ${lib'.root}; direnv exec . nvim; cd -";
      nixos-build = "${exe} os switch";
      nixos-upgrade = "${exe} os switch --update";
      nixos-clean = "${exe} clean all --nogcroots";
    };
  };
}
