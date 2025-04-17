# Getting MGSV to a playable state on Linux
## NixOS
All that's required is the general NixOS Steam config options for playing Metal Gear Solid 5.

In System Config
```nix
programs.steam = {
    enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
};
```

Steam config aside, the below udev rule should be set to prevent steam (and thus MGSV) from viewing keyboard as a controller and breaking the controls in game.

```nix
services.udev.extraRules = ''
    SUBSYSTEM=="input", ATTRS{idVendor}=="3434", ATTRS{idProduct}=="0161", ENV{ID_INPUT_JOYSTICK}="" 
'';
_note: can acquire keyboard device idVendor and idProduct values with lsusb, ensure setting right side of operator and not the attribute key (left of the == operator)_

```

## Modding with Snakebite
Run both the snakebite installer and snakebite from steam.
1. Download snakebite installer from Nexus Mods
2. Add Snakebite installer to steam and enable compatibility mode (run with proton)
3. Install Snakebite;
    - Install path should be on linux filesystem (i.e. in ~/Downloads)
4. Add Installed Snakebite.exe to Steam
5. Run Snakebite and point it at Metal Gear Solid 5 (path in linux filesystem)

Snakebite should be able to be run through steam now and work as intended.
