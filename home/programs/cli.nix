{ pkgs, ... }:
{
  home.packages = with pkgs; [
    uutils-coreutils-noprefix
  ];

  home.shellAliases = with pkgs; {
    cat = "${lib.getExe bat} --plain";
    budget = "${lib.getExe budget-tracker-tui}";
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
  };
}
