{ pkgs, globals, ... }: if ! globals.experimental.oxidation.enable then {}
else {
  home.packages = with pkgs; [
    hyperfine procs sd du-dust tokei bandwhich grex fclones rm-improved ripgrep
  ];

  programs.git.delta.enable = true;

  home.shellAliases = {
    cat = "bat --plain";
    top = "btm";
    ps = "procs";
    du = "dust";
    grep = "rg";
    fzf = "sk";
  };
}
