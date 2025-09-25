self: inputs: {
  nixosModules = {
    hyprland = import ./nixosModules/hyprland.nix self inputs.hyprland;
    gnome = import ./nixosModules/gnome.nix self;
    antec-flux-pro = import ./nixosModules/antec.nix self;
  };
  homeManagerModules = {
    quickshell = import ./homeManagerModules/quickshell.nix self inputs.quickshell inputs.home-manager;
    hyprland = import ./homeManagerModules/hyprland self inputs.hyprland;
  };
}
