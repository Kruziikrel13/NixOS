{
  home.shell.enableBashIntegration = true;
  programs.bash = {
    enable = true;
    enableCompletion = true;
    enableVteIntegration = true;
    shellAliases = {
      home-edit = "cd /etc/nixos/modules/home && nvim && cd -";
      nix-edit = "cd /etc/nixos && nvim && cd -";
      gc = "nix-collect-garbage -d";
      sgc = "sudo nix-collect-garbage -d";
      srb = "sudo nixos-rebuild switch";
    };
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
