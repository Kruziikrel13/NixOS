{
  self,
  lib,
  config,
  ...
}:
let
  inherit (self.lib) root;
  inherit (self.lib.options) mkBoolOpt;
  cfg = config.modules.shell.nh;
  exe = lib.meta.getExe config.programs.nh.package;
in
{
  options.modules.shell.nh.enable = mkBoolOpt false;
  config = lib.mkIf cfg.enable {
    programs.nh = {
      enable = true;
      flake = root;
    };

    environment.shellAliases = {
      search = "${exe} search";
      nixos-edit = "cd ${root}; direnv-instant start . nvim; cd -";
      nixos-build = "${exe} os switch";
      nixos-upgrade = "${exe} os switch --update";
      nixos-clean = "${exe} clean all --nogcroots";
    };
  };
}
