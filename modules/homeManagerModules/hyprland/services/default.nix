{
  imports = [
    ./hypridle.nix
    ./hyprlock.nix
  ];
  services.hyprpolkitagent.enable = true;
}
