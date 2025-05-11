{ 
  globals, 
  lib, 
  inputs, 
  config, 
  ... 
}:
with lib;
{
  imports = [ ../hardware-configuration.nix ];

  # Required for flakes
  programs.git.enable = true;
  documentation.nixos.enable = false;

  nixpkgs.config.allowUnfree = true;

  nix = {
    channel.enable = false;
    # Map all flake inputs as attributes to nix registry and add them to nix path
    registry = mapAttrs(_: v: {flake = v;}) (filterAttrs (_: v: isType "flake" v) inputs);
    nixPath = mapAttrsToList (key: _: "${key}=flake:${key}") config.nix.registry;
    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;

      # Prevents direnv results getting cleaned up
      keep-derivations = true;
      keep-outputs = true;

      trusted-users = [ "root" "@wheel" ];
      warn-dirty = false;
    };
  };

  programs.dconf.enable = true;
  programs.neovim.enable = true;

  boot = {
    plymouth.enable = true;
    tmp.cleanOnBoot = true;
    loader = {
      timeout = 2;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      systemd-boot = {
        enable = true;
        editor = false;
        consoleMode = "max";
        configurationLimit = 10;
        windows = mkIf globals.boot.windows.enable {
          "10-pro" = {
            title = "Windows 11 Pro";
            efiDeviceHandle = globals.boot.windows.efiDeviceHandle;
            sortKey = "a_windows";
          };
        };
      };
    };
  };
  system.stateVersion = "24.11";
}
