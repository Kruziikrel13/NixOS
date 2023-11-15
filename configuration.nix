{
  imports = [/etc/nixos/hardware-configuration.nix ./config];

  opts = {
    System = {
      Version = "23.11";
      Hostname = "Alternate-Solutions";
      Username = "O5-1";
      HashedPassword = "$6$nBLGdGnAVE654oku$62zGzmYbwTa15QgtalCmSlud8OqVll07ur/FmVj/WXKr.py9ORaG1pkIFxfQPFEGuQKo1mbJgrbDKRkMXWgs//"; # Generate through mkpasswd -m sha512
      Modules = {
        EnableBluetooth = false;
        EnableAudio = false;
      };
    };
  };
}
