# Antec
Antec Flux Pro Display hardware module for NixOS.

Allows the Antec Flux Pro case to display CPU and GPU temperatures.

## Usage
To find the correct device names and temperature types run `antec-flux-pro-display`.

### Module Options
```nix
hardware.antec = {
  enable = true;
  cpu-device = "k10temp";
  gpu-device = "amdgpu";
  cpu-temp-type = "tctl";
  gpu-temp-type = "edge";
};
```

# Keychron
Keychron Keyboard module for NixOS.

Fixes an issue with Keychron keyboards on Linux that causes Steam and other programs to think the keyboard is a joystick device and prevent proper keyboard input.

Also enables qmk firmware support and installs via for configuring the keyboard.

## Usage
Can find idVendor and idProduct values with `lsusb`.

### Module Options
```nix
hardware.keyboard.keychron = {
  enable = true;
  idVendor = "3434"; # Keychron Vendor ID
  idProduct = "0161"; # Keychron Q6 Product ID
};
```
