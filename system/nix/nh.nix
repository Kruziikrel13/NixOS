{config, ...}: {
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep-since 7d";
    };
  };

  programs.bash.shellAliases = {
    nixos-edit = "cd /etc/nixos && nvim && cd -";
    nixos-build = "${config.programs.nh.package}/bin/nh os switch /etc/nixos";
    nixos-upgrade = "${config.programs.nh.package}/bin/nh os switch /etc/nixos --update";
    nixos-clean = "${config.programs.nh.package}/bin/nh clean all";
  };
}
