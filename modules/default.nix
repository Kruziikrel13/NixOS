self: inputs: {
  homeManagerModules = {
    quickshell = import ./quickshell.nix self inputs.quickshell inputs.home-manager;
  };
}
