{pkgs, self, config, ...}: {
  xdg.configFile.nvim = {
   enable = true;
   target = "nvim/lua";
   recursive = true;
   source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/config/sentinel.nvim/lua;
  };
  xdg.configFile.nvimInit = {
   enable = true;
   target = "nvim/init.lua";
   source = config.lib.file.mkOutOfStoreSymlink /etc/nixos/config/sentinel.nvim/init.lua;
  };
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraPackages = with pkgs; [
      gcc lazygit ripgrep nixd lua-language-server copilot-language-server-fhs typescript-language-server
    ];
  };
}
