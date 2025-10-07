{
  lib,
  rustPlatform,
  fetchFromGitHub,
  lm_sensors,
  usbutils,
  writeTextFile,

  cpu_device ? "k10temp",
  cpu_temp_type ? "tctl",
  gpu_device ? "amdgpu",
  gpu_temp_type ? "edge",
}:
rustPlatform.buildRustPackage rec {
  pname = "antec-flux-pro";
  version = "1.0";

  src = fetchFromGitHub {
    owner = "Reikooters";
    repo = "antec-flux-pro-display";
    rev = "v${version}";
    hash = "sha256-1omQVWSIrwQIsB+pfhDz0N8A3T/qMRBlLseBxANMS9c=";
  };
  cargoHash = "sha256-GR/ZcT1v1Tv4KAfD+IldhkYwz0kaT/lhN6wXtMbmO9o=";

  buildInputs = [
    lm_sensors
    usbutils
  ];

  outputs = [
    "out"
    "udev"
  ];

  udevRules = writeTextFile {
    name = "99-antec-flux-pro.rules";
    text = ''SUBSYSTEM=="usb", ATTR{idVendor}=="2022", ATTR{idProduct}=="0522", GROUP="plugdev", TAG+="uaccess"'';
  };

  configFile = writeTextFile {
    name = "config.conf";
    text = ''
      cpu_device=${cpu_device}
      cpu_temp_type=${cpu_temp_type}
      gpu_device=${gpu_device}
      gpu_temp_type=${gpu_temp_type}
      update_interval=1000
    '';
  };

  # Replace hardcoded config path with path to nix store
  postPatch = ''
    substituteInPlace src/main.rs \
      --replace "PathBuf::from(\"/etc/antec-flux-pro-display\");" \
      "PathBuf::from(\"$out/etc/antec-flux-pro-display\");"
  '';

  postInstall = ''
    install -Dm644 ${udevRules} $udev/lib/udev/rules.d/99-antec-flux-pro.rules
    install -D ${configFile} $out/etc/antec-flux-pro-display/config.conf
  '';

  meta = {
    homepage = "https://github.com/Reikooters/antec-flux-pro-display";
    description = "Antec Flux Pro Hardware Display Service";
    mainProgram = "antec-flux-pro-display";
    license = lib.licenses.gpl3;
  };
}
