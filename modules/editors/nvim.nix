{
  lib,
  lib',
  config,
  pkgs,
  self,
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
    home.configFiles."nvim".source = "${toString self}/config/sentinel.nvim";
    environment = {
      systemPackages = [
        (pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped {
          viAlias = true;
          vimAlias = true;
          waylandSupport = true;
          wrapRc = false;
          wrapperArgs = [
            "--suffix"
            "PATH"
            ":"
            (lib.makeBinPath (
              with pkgs;
              [
                gcc
                ripgrep
                fzf
                lazygit
                tree-sitter
                github-copilot-cli

                lua-language-server
                stylua
              ]
              ++ cfg.extraPackages
            ))
          ];
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
