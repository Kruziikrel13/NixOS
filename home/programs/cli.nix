{ pkgs, ... }:
{
  home.packages = with pkgs; [
    uutils-coreutils-noprefix
    tree
  ];

  home.shellAliases.cat = "${pkgs.bat}/bin/bat --plain";
  programs.bat.enable = true;

  programs.eza = {
    enable = true;
    icons = "auto";
    git = true;
    enableBashIntegration = true;
    extraOptions = [
      "--git-repos"
      "--hyperlink"
    ];
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.ripgrep.enable = true;
  programs.ripgrep-all.enable = true;
  programs.fd.enable = true;
  programs.bottom.enable = true;

  programs.helix = {
    enable = true;
    package = pkgs.evil-helix;
  };
}
