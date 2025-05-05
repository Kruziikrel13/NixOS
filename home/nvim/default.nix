{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraPackages = with pkgs; [ gcc lazygit ripgrep nixd lua-language-server copilot-language-server-fhs ];
  };
}
