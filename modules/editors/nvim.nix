{
  lib,
  lib',
  config,
  neovim-nightly-overlay,
  ...
}:
let
  inherit (lib.modules) mkIf;
  inherit (lib'.options) mkBoolOpt;
  cfg = config.modules.editors.nvim;
in
{
  options.modules.editors.nvim.enable = mkBoolOpt false;
  config = mkIf (cfg.enable or config.modules.editors.default == "nvim") {
    imports = [ neovim-nightly-overlay.overlays.default ];
    modules.editors.nvim.enable = lib.mkDefault true;
    programs.neovim = {
      enable = true;
      defaultEditor = config.modules.editors.default == "nvim";
      viAlias = true;
      vimAlias = true;
    };
  };
}
