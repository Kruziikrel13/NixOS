{
  lib,
  config,
  ...
}:
let
  inherit (lib.modules) mkIf;
  inherit (lib) mkMerge elem;
in
mkIf (config.modules.profiles.role == "workstation") (mkMerge [
  {
    boot = {
      # Optimizations for desktops/gaming
      kernel.sysctl = {
        "kernel.sched_cfs_bandwidth_slice_us" = 3000;
        # This is required due to some games being unable to reuse their TCP ports
        # if they're killed and restarted quickly - the default timeout is too
        # large.
        "net.ipv4.tcp_fin_timeout" = 5;
        # Prevents intentional slowdowns in case games experience split locks This
        # is valid for kernels v6.0+
        "kernel.split_lock_mitigate" = 0;
        # USE MAX_INT - MAPCOUNT_ELF_CORE_MARGIN.
        # see comment in include/linux/mm.h in the kernel tree.
        "vm.max_map_count" = 2147483642;
        # The default maximum is too low, which starves IO hungry apps.
        "fs.inotify.max_user_watches" = 524288;
      };
      initrd.availableKernelModules = [
        "xhci_pci" # USB 3.0
        "usb_storage" # USB mass storage devices
        "usbhid" # USB human interface devices
        "ahci" # SATA devices on modern AHCI controllers
        "sd_mod" # SCSI, SATA, and IDE devices
        "thunderbolt" # Thunderbolt devices
      ];
    };
    powerManagement.cpuFreqGovernor = lib.mkDefault "performance";
  }

  # Handle networking with systemd if wifi is not required
  (mkIf (!elem "wifi" config.modules.profiles.hardware) {
    networking = {
      useDHCP = false;
      useNetworkd = true;
    };

    systemd = {
      network = {
        networks = {
          "30-wired" = {
            enable = true;
            name = "en*";
            networkConfig.DHCP = "yes";
            networkConfig.IPv6PrivacyExtensions = "kernel";
            linkConfig.RequiredForOnline = "no"; # don't hang at boot (if dc'ed)
            dhcpV4Config.RouteMetric = 1024;
          };
          "30-wireless" = {
            enable = true;
            name = "wl*";
            networkConfig.DHCP = "yes";
            networkConfig.IPv6PrivacyExtensions = "kernel";
            linkConfig.RequiredForOnline = "no"; # don't hang at boot (if dc'ed)
            dhcpV4Config.RouteMetric = 2048; # prefer wired
          };
        };
        # systemd-networkd-wait-online waits forever for *all* interfaces to be
        # online before passing; which is unlikely to ever happen.
        wait-online = {
          anyInterface = true;
          timeout = 30;

          # The anyInterface setting is still finnicky for some networks, so I
          # simply turn off the whole check altogether.
          enable = false;
        };
      };
    };
    boot.initrd.systemd.network.wait-online = {
      anyInterface = true;
      timeout = 10;
    };
  })
])
