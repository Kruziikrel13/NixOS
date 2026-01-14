{
  lib,
  lib',
  config,
  pkgs,
  neovim-nightly-overlay,
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
    finalPackage = lib.mkOption {
      type = package;
      readOnly = true;
    };
  };
  config = lib.mkIf cfg.enable {
    nixpkgs.overlays = [ neovim-nightly-overlay.overlays.default ];
    environment = {
      systemPackages = [ cfg.finalPackage ];
      shellAliases.vimdiff = "nvim -d";
      variables = {
        EDITOR = lib.mkOverride 900 "nvim";
        VISUAL = lib.mkOverride 900 "nvim";
      };
      pathsToLink = [ "/share/nvim" ];
    };
    modules.editors.nvim.finalPackage = pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped {
      viAlias = true;
      vimAlias = true;
      waylandSupport = true;
      wrapperArgs = with pkgs; [
        "--suffix"
        "PATH"
        ":"
        (lib.makeBinPath (
          [
            gcc
            ripgrep
            fzf
            lazygit
            tree-sitter
            github-copilot-cli
          ]
          ++ cfg.extraPackages
        ))
      ];
    };
  };
}
