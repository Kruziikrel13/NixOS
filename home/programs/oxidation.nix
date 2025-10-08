{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      uutils-coreutils-noprefix
      procs
      hyperfine
      mprocs
    ];
    shellAliases = {
      ps = "procs";
    };
  };
  programs = {
    fd.enable = true;
    bottom.enable = true;
    helix = {
      enable = true;
      package = pkgs.evil-helix;
    };
    eza = {
      enable = true;
      enableBashIntegration = true;
      git = true;
      icons = "auto";
    };
    zoxide = {
      enable = true;
      enableBashIntegration = true;
      options = [ "--cmd cd" ];
    };
  };
}
