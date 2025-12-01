{ pkgs, ... }:
{
  home.packages = with pkgs; [
    uutils-coreutils-noprefix
    tree
  ];

  home.shellAliases = {
    cat = "${pkgs.bat}/bin/bat --plain";
    budget = "${pkgs.budget-tracker-tui}/bin/Budget_Tracker";
  };

  programs = {
    bat.enable = true;

    eza = {
      enable = true;
      icons = "auto";
      git = true;
      enableBashIntegration = true;
      extraOptions = [
        "--git-repos"
        "--hyperlink"
      ];
    };

    zoxide = {
      enable = true;
      enableBashIntegration = true;
    };

    ripgrep.enable = true;
    ripgrep-all.enable = true;
    fd.enable = true;
    bottom.enable = true;

    helix = {
      enable = true;
      package = pkgs.evil-helix;
    };
  };
}
