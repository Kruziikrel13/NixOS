{ pkgs, ... }:
{
  home.packages = with pkgs; [
    uutils-coreutils-noprefix
  ];

  home.shellAliases = with pkgs; {
    budget = "${lib.getExe budget-tracker-tui}";
  };

  programs = {

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

    ripgrep.enable = true;
    ripgrep-all.enable = true;
    fd.enable = true;
    bottom.enable = true;
  };
}
