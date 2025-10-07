self: inputs: {
  nixosModules = {
    gnome = import ./nixosModules/gnome.nix self;
    antec = import ./nixosModules/antec.nix self;
    keychron = import ./nixosModules/keychron.nix self;
    personalModule = import ./personalModule self inputs;
  };
  homeManagerModules = {
    quickshell = import ./homeManagerModules/quickshell.nix self inputs.quickshell inputs.home-manager;
  };
}
