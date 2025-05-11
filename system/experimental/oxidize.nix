{pkgs, globals, ...}: if !globals.experimental.oxidation.enable then {}
else {
  environment.systemPackages = with pkgs; [
    uutils-coreutils-noprefix
    uutils-findutils
  ];
}
