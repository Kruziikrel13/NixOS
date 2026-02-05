{
  lib,
  lib',
  config,
  pkgs,
  ...
}:
let
  inherit (lib'.options) mkOpt mkBoolOpt;
  cfg = config.modules.editors.nvim;
in
{
  options.modules.editors.nvim = with lib.types; {
    enable = mkBoolOpt (config.modules.editors.default == "nvim");
    extraPackages = mkOpt (listOf package) [ ];
  };
  config = lib.mkIf cfg.enable {
    home.configFiles.sentinel = {
      target = "nvim";
      source = lib'.relativeToRoot "config/sentinel.nvim";
    };
    environment = {
      systemPackages = [
        (pkgs.sentinel.override {
          inherit (cfg) extraPackages;
        })
      ];
      shellAliases = {
        vimdiff = "nvim -d";
      };
      variables = {
        EDITOR = lib.mkOverride 900 "nvim";
        VISUAL = lib.mkOverride 900 "nvim";
      };
      pathsToLink = [ "/share/nvim" ];
    };
  };
}
