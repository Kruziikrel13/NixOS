{
  boot = {
    supportedFilesystems = {
      btrfs = true;
      ext4 = true;
    };
    tmp.cleanOnBoot = true;
    kernelParams = ["systemd.show_status=auto" "amd_pstate=active"];
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
        extraInstallCommands = ''
          sed -i 's/^default.*/default @saved/' /boot/loader/loader.conf
        '';
      };
    };
  };

  # TODO Support CPU Power Here? Or Kernel Specific CPU Power Support in Hosts
}
