{
  pkgs,
  root,
  config,
  ...
}: {
  xdg.configFile.nvim = {
    enable = true;
    target = "nvim";
    recursive = true;
    source =
      config.lib.file.mkOutOfStoreSymlink "${root}/.config/sentinel.nvim";
  };
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraPackages = with pkgs; [
      gcc
      lazygit
      ripgrep
      nixd
      stylua
      alejandra
      statix
      lua-language-server
      copilot-language-server-fhs
      typescript-language-server
    ];
  };
}
