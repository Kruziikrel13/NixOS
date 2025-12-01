{
  pkgs,
  pathLib,
  config,
  ...
}:
{
  xdg.configFile.nvim = {
    enable = true;
    target = "nvim";
    recursive = true;
    source = config.lib.file.mkOutOfStoreSymlink (pathLib.relativeToRoot "config/sentinel.nvim");
  };
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraPackages = with pkgs; [
      ## Dependencies
      gcc
      ripgrep
      fzf
      lazygit
      tree-sitter
      github-copilot-cli

      ## Language Servers
      nil
      nixd
      statix
      deadnix
      nixfmt-rfc-style
      copilot-language-server

      lua-language-server
      stylua
    ];
  };
}
