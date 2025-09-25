{
  rustPlatform,
  fetchFromGitHub,
  lm_sensors,
  usbutils,
  nix-update-script,

  cpu_device ? "k10temp",
  cpu_temp_type ? "tctl",
  gpu_device ? "amdgpu",
  gpu_temp_type ? "edge",
  update_interval ? "1000",
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

  passthru = {
    updateScript = nix-update-script { };
  };

  meta = {
    homepage = "https://github.com/Reikooters/antec-flux-pro-display";
    description = "Antec Flux Pro Hardware Display Service";
    mainProgram = "antec-flux-pro-display";
  };
}
