{
  lib,
  lib',
  config,
  neovim-nightly-overlay,
  ...
}:
let
  inherit (lib'.options) mkBoolOpt;
  cfg = config.modules.editors.nvim;
in
{
  options.modules.editors.nvim.enable = mkBoolOpt (config.modules.editors.default == "nvim");
  config = lib.mkIf cfg.enable {
    nixpkgs.overlays = [ neovim-nightly-overlay.overlays.default ];
    programs.neovim = {
      enable = true;
      defaultEditor = config.modules.editors.default == "nvim";
      viAlias = true;
      vimAlias = true;
    };
  };
}
