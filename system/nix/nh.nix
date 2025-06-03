{
  config,
  root,
  ...
}: {
  programs.nh.enable = true;

  environment.shellAliases = {
    nixos-edit = "cd ${root}; nvim; cd -";
    nixos-build = "${config.programs.nh.package}/bin/nh os switch ${root}";
    nixos-upgrade = "${config.programs.nh.package}/bin/nh os switch ${root} --update";
    nixos-clean = "${config.programs.nh.package}/bin/nh clean all --nogcroots";
  };
}
