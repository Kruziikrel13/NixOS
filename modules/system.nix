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
    users.groups.seat.name = "seat";
    users.users = {
      ${cfg.Username} = {
        uid = 1001;
        name = cfg.Username;
        isNormalUser = true;
        group = "users";
        extraGroups = [ "wheel" "audio" "video" "power" "disk" "optical" "storage" "tty" "networkmanager" "network" "seat" "greeter" "polkitd" ];
        hashedPassword = cfg.HashedPassword;
        packages = with pkgs; [
          walker ranger pulsemixer protonmail-desktop discord spotify heroic dust brightnessctl via
        ];
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
    services = {
      auto-cpufreq.enable = true;
      fstrim.enable = true;
      gvfs.enable = true;
      pipewire = {
        enable = true;
        audio.enable = true;
        pulse.enable = true;
        jack.enable = true;
      };
    };
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
    environment.localBinInPath = true;
    time = {
      timeZone = cfg.Timezone;
      hardwareClockInLocalTime = true;
    };
    i18n = {
      defaultLocale = "en_US.UTF-8";
    };
    programs = {
      nix-ld.enable = true;
      git.enable = true;
      neovim.enable = true;
      firefox.enable = true;
    };
    hardware = {
      enableAllHardware = true;
      enableAllFirmware = true;
      graphics.enable = true;
      graphics.enable32Bit = true;
      keyboard.qmk.enable =  true;
      cpu.amd = {
        updateMicrocode = true;
        sev.enable = true;
      };
    };
    fonts = {
      packages = with pkgs; [
        symbola
        noto-fonts-cjk-sans
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
        noto-fonts-monochrome-emoji
        nerd-fonts._0xproto
        nerd-fonts._3270
        nerd-fonts.agave
        nerd-fonts.anonymice
        nerd-fonts.arimo
        nerd-fonts.aurulent-sans-mono
        nerd-fonts.bigblue-terminal
        nerd-fonts.bitstream-vera-sans-mono
        nerd-fonts.blex-mono
        nerd-fonts.caskaydia-cove
        nerd-fonts.caskaydia-mono
        nerd-fonts.code-new-roman
        nerd-fonts.comic-shanns-mono
        nerd-fonts.commit-mono
        nerd-fonts.cousine
        nerd-fonts.d2coding
        nerd-fonts.daddy-time-mono
        nerd-fonts.departure-mono
        nerd-fonts.dejavu-sans-mono
        nerd-fonts.droid-sans-mono
        nerd-fonts.envy-code-r
        nerd-fonts.fantasque-sans-mono
        nerd-fonts.fira-code
        nerd-fonts.fira-mono
        nerd-fonts.geist-mono
        nerd-fonts.go-mono
        nerd-fonts.gohufont
        nerd-fonts.hack
        nerd-fonts.hasklug
        nerd-fonts.heavy-data
        nerd-fonts.hurmit
        nerd-fonts.im-writing
        nerd-fonts.inconsolata
        nerd-fonts.inconsolata-go
        nerd-fonts.inconsolata-lgc
        nerd-fonts.intone-mono
        nerd-fonts.iosevka
        nerd-fonts.iosevka-term
        nerd-fonts.iosevka-term-slab
        nerd-fonts.jetbrains-mono
        nerd-fonts.lekton
        nerd-fonts.liberation
        nerd-fonts.lilex
        nerd-fonts.martian-mono
        nerd-fonts.meslo-lg
        nerd-fonts.monaspace
        nerd-fonts.monofur
        nerd-fonts.monoid
        nerd-fonts.mononoki
        nerd-fonts.mplus
        nerd-fonts.noto
        nerd-fonts.open-dyslexic
        nerd-fonts.overpass
        nerd-fonts.profont
        nerd-fonts.proggy-clean-tt
        nerd-fonts.recursive-mono
        nerd-fonts.roboto-mono
        nerd-fonts.shure-tech-mono
        nerd-fonts.sauce-code-pro
        nerd-fonts.space-mono
        nerd-fonts.symbols-only
        nerd-fonts.terminess-ttf
        nerd-fonts.tinos
        nerd-fonts.ubuntu
        nerd-fonts.ubuntu-mono
        nerd-fonts.ubuntu-sans
        nerd-fonts.victor-mono
        nerd-fonts.zed-mono
      ];
      fontDir.decompressFonts = true;
      fontconfig.defaultFonts.monospace = [ "JetBrains Nerd Font Mono"];
    };

    systemd.services.seatd = {
      enable = true;
      path = [ pkgs.seatd ];
      description = "Seat Management Daemon";
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.seatd}/bin/seatd -g seat";
        Restart = "always";
        RestartSec = 1;
      };
    };

    boot = {
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
