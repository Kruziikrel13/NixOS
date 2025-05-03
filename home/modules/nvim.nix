{ osConfig, config, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    package = osConfig.programs.neovim.package;
    extraPackages = with pkgs; [ gcc lazygit ripgrep ];
  };
}
