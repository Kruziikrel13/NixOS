{ config, lib, pkgs, ... }:

with lib;
let cfg = config.opts; in
  {
  options = with types; {
    opts = {
      Username = mkOption {
        type = str;
        default = "usr";
      };
      HashedPassword = mkOption {
        type = nullOr (passwdEntry str);
        default = null;
      };
      Hostname = mkOption {
        type = str;
        default = "NixOS";
      };
      Timezone = mkOption {
        type = str;
        default = "Australia/Brisbane";
      };
    };
  };

  config = {
    security.pam.services.hyprlock = {};
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
    services = {
      auto-cpufreq.enable = true;
      fstrim.enable = true;
      gvfs.enable = true;
      ratbagd.enable = true;
    };
    environment.localBinInPath = true;
    time = {
      timeZone = cfg.Timezone;
      hardwareClockInLocalTime = true;
    };
    i18n = {
      defaultLocale = "en_AU.UTF-8";
    };
    programs = {
      nix-ld.enable = true;
      git.enable = true;
      neovim.enable = true;
      firefox.enable = true;

      uwsm.enable = true;
      hyprland = {
        enable = true;
        xwayland.enable = true;
        withUWSM = true;
      };
    };
    fonts = {
      packages = with pkgs; [ nerd-fonts.jetbrains-mono nerd-fonts.noto ];
      fontDir.decompressFonts = true;
      fontconfig.defaultFonts.monospace = [ "JetBrains Nerd Font Mono"];
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
  };
}
