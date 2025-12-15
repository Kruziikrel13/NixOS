{
  lib,
  config,
  pkgs,
  nix-gaming,
  ...
}:
with lib;
mkMerge [
  (mkIf (any (s: hasPrefix "audio" s) config.modules.profiles.hardware) {
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    security.rtkit.enable = true;
    user.extraGroups = [ "audio" ];
    user.packages = with pkgs; [
      pulsemixer

      # Silences DBus error noise in journalctl
      at-spi2-core
    ];
    services.pulseaudio.enable = mkForce false;
  })

  (mkIf (elem "audio/realtime" config.modules.profiles.hardware) {
    imports = [ nix-gaming.nixosModules.pipewireLowLatency ];
    services.pipewire.lowLatency = {
      enable = true;
      quantum = 64;
      rate = 384000;
    };
    services.pipewire.wireplumber.enable = true;
  })
]
