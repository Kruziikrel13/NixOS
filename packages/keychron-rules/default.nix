{
  writeTextFile,

  idProduct ? null,
}:
# See Keychron Support on Wiki https://github.com/Kruziikrel13/NixOS/wiki/Hardware-Fixes#keychron-keyboards stdenvNoCC.mkDerivation rec { pname = "keychron-rules"; dontBuild = true; nativeBuildInputs = [ udevCheckHook ]; doInstallCheck = true; udevRules = writeTextFile { name = "99-keychron.rules"; text = ''''; }; installPhase = '' runHook preInstall install -Dm644 ${udevRules} $out/lib/udev/rules.d/99-keychron.rules runHook postInstall ''; meta = { homepage = "https://github.com/kruziikrel13/nixos"; description = "Udev rules for Keychron keyboards"; maintainers = "kruziikrel13"; };
writeTextFile {
  name = "60-keychron.rules";
  text = ''
    SUBSYSTEM=="input", ATTRS{idVendor}=="3434", ATTRS{idProduct}=="${idProduct}", ENV{ID_INPUT_JOYSTICK}=""
  '';
}
