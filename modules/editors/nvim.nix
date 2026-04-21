{
  self,
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (self.lib.options) mkBoolOpt;
  cfg = config.modules.editors.nvim;
in
{
  options.modules.editors.nvim.enable = mkBoolOpt (config.modules.editors.default == "nvim");
  config = lib.mkIf cfg.enable {
    environment = {
      systemPackages = [ pkgs.sentinel ];
      shellAliases.vimdiff = "nvim -d";
      variables = {
        EDITOR = lib.mkOverride 900 "nvim";
        VISUAL = lib.mkOverride 900 "nvim";
      };
      pathsToLink = [ "/share/nvim" ];
    };
  };
}
