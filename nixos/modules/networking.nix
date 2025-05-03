{ globals, lib, ... }:
{
  services.sshd.enable = globals.networking.ssh.enable;
  networking = {
    hostName = globals.networking.hostName;
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowPing = false;
    };
  };
  users.users = {
    ${globals.user.name} = {
      extraGroups = [ "networkmanager" "network"];
    };
  };

  hardware.bluetooth = lib.mkIf globals.networking.bluetooth.enable {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = globals.networking.bluetooth.enable;
}
