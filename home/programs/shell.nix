{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      hyperfine procs sd du-dust bandwhich grex fclones rm-improved tokei cyme
    ];
    shell = {
      enableBashIntegration = true;
      enableNushellIntegration = true;
    };
    shellAliases = {
      top = "btm";
      ps = "procs";
      du = "dust";
      fzf = "sk";
    };
  };
  programs = {
    bat.enable = true;
    bottom.enable = true;
    feh.enable = true;
    bash = {
      enable = true;
      enableCompletion = true;
      enableVteIntegration = true;
    };
    eza = {
      enable = true;
      enableBashIntegration = true;
      git = true;
      icons = "auto";
    };
    yazi = {
      enable = true;
      enableBashIntegration = true;
    };

    nushell = {
      enable = true;
    };
    direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };
    zoxide = {
      enable = true;
      enableBashIntegration = true;
      options = [
        "--cmd cd"
      ];
    };
  };
}
