{pkgs, self, config, ...}: {
  xdg.configFile.nvim = {
   enable = true;
   target = "nvim";
   recursive = true;
   source = config.lib.file.mkOutOfStoreSymlink "${self}/.config/sentinel.nvim";
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
