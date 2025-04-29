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
    users.users = {
      ${cfg.Username} = {
        name = cfg.Username;
        isNormalUser = true;
        group = "users";
        extraGroups = [ "wheel" "audio" "video" "power" "disk" "optical" "storage" "tty" "networkmanager" "network" "seat" "greeter" "polkitd" "pipewire" ];
        hashedPassword = cfg.HashedPassword;
      };
    };
    networking = {
      hostName = cfg.Hostname;
      networkmanager.enable = true;
      firewall.enable = true;
    };
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
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      audio.enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
    };
    services = {
      auto-cpufreq.enable = true;
      fstrim.enable = true;
      gvfs.enable = true;
      ratbagd.enable = true;
    };
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
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
    hardware = {
      enableAllHardware = true;
      enableAllFirmware = true;
      graphics.enable = true;
      graphics.enable32Bit = true;
      logitech.wireless.enable = true;
      logitech.wireless.enableGraphical = true;
      keyboard.qmk.enable =  true;
      cpu.amd = {
        updateMicrocode = true;
        sev.enable = true;
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
