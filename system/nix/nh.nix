{config, root, ...}: {
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep-since 7d";
    };
  };

  environment.shellAliases = {
    nixos-edit = "cd ${root} && nvim && cd -";
    nixos-build = "${config.programs.nh.package}/bin/nh os switch ${root}";
    nixos-upgrade = "${config.programs.nh.package}/bin/nh os switch ${root} --update";
    nixos-clean = "${config.programs.nh.package}/bin/nh clean all";
  };
}
