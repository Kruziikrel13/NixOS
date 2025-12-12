{ nix-gaming, lib, ... }:
{
  imports = [ nix-gaming.nixosModules.pipewireLowLatency ];
  services.pipewire = {
    enable = true;
    pulse.enable = true;

    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;

    lowLatency = {
      enable = true;
      quantum = 64;
      rate = 384000;
    };
  };
  security.rtkit.enable = lib.mkDefault true;

  security.pam.loginLimits = [
    {
      domain = "@audio";
      item = "memlock";
      type = "-";
      value = "unlimited";
    }
    {
      domain = "@audio";
      item = "rtprio";
      type = "-";
      value = "99";
    }
    {
      domain = "@audio";
      item = "nofile";
      type = "soft";
      value = "99999";
    }
    {
      domain = "@audio";
      item = "nofile";
      type = "hard";
      value = "524288";
    }
  ];
}
