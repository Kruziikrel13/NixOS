{
config,
...
}: {
  programs.bash.shellAliases = if config.programs.nh.enable then {
    nixos-edit = "cd /etc/nixos && nvim && cd -";
    nixos-build = "${config.programs.nh.package}/bin/nh os switch /etc/nixos";
    nixos-upgrade = "${config.programs.nh.package}/bin/nh os switch /etc/nixos --update";
    nixos-clean = "${config.programs.nh.package}/bin/nh clean all";
  } else {
    nixos-edit = "cd /etc/nixos && nvim && cd -";
    nixos-build = "sudo nixos-rebuild switch";
    nixos-upgrade = "sudo nix flake update --flake /etc/nixos && sudo nixos-rebuild switch";
    nixos-clean = "sudo nix-collect-garbage -d";
    nixos-local-clean = "nix-collect-garbage -d";
  };

}
