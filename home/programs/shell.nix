{pkgs, ...}: {
  home.packages = with pkgs; [
    hyperfine procs sd du-dust bandwhich grex fclones rm-improved tokei cyme
  ];
  programs.bat.enable = true;
  programs.bottom.enable = true;
  programs.feh.enable = true;
  home.shell = {
    enableBashIntegration = true;
    enableNushellIntegration = true;
  };
  home.shellAliases = {
    top = "btm";
    ps = "procs";
    du = "dust";
    fzf = "sk";
  };
  programs.bash = {
    enable = true;
    enableCompletion = true;
    enableVteIntegration = true;
  };
  programs.eza = {
    enable = true;
    enableBashIntegration = true;
    git = true;
    icons = "auto";
  };
  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.nushell = {
    enable = true;
  };
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };
  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    options = [
      "--cmd cd"
    ];
  };

}
