{ nix-gaming, lib, ... }:
{
  imports = [ nix-gaming.nixosModules.pipewireLowLatency ];
  services.pipewire = {
    enable = true;
    lowLatency = {
      enable = true;
      quantum = 32;
      rate = 384000;
    };
  };

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
