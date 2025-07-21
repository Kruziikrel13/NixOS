self: inputs: {
  nixosModules = {
    hyprland = import ./hyprland self inputs.hyprland inputs.home-manager;
  };
  homeManagerModules = {
    quickshell = import ./quickshell.nix self inputs.quickshell inputs.home-manager;
    hyprland = import ./hyprland/home.nix self inputs.hyprland;
  };
}
