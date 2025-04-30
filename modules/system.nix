{ ... }:
{
  nix = {
    settings = {
      keep-outputs = false;
      keep-derivations = false;
      show-trace = false;
      auto-optimise-store = true;
      sandbox = true;
    };
    gc = {
      automatic = false;
      dates = "weekly";
      options = "--delete-old";
    };
    optimise = {
      automatic = true;
      dates = [ "monday" ];
    };
  };
  nixpkgs = {
    config.checkMeta = true;
    config.allowUnfree = true;
  };
  boot = {
    plymouth.enable = true;
    readOnlyNixStore = true;
    loader = {
      systemd-boot.enable = true;
      timeout = 5;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };
  };
}
