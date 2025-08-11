{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      uutils-coreutils-noprefix
      procs
      hyperfine
      du-dust
      fclones
      tokei
      bandwhich
      xh
      just
      mask
      mprocs
    ];
    shellAliases = {
      ps = "procs";
      du = "dust";
    };
  };
  programs = {
    fd.enable = true;
    bat.enable = true;
    bottom.enable = true;
    nushell.enable = false;
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
      options = ["--cmd cd"];
    };
  };
}
