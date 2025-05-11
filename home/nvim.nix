{ pkgs, config, ... }:
{
  xdg.configFile."nvim/lua" = {
    enable = true;
    recursive = true;
    source = config.lib.file.mkOutOfStoreSymlink ./.config/nvim/lua;
  };
  xdg.configFile."nvim/init.lua" = {
    source = config.lib.file.mkOutOfStoreSymlink ./.config/nvim/init.lua;
  };
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraPackages = with pkgs; [ gcc lazygit ripgrep nixd lua-language-server copilot-language-server-fhs vtsls typescript-language-server ];
  };
}
