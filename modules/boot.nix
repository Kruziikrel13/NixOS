{
  console.earlySetup = true;
  boot.loader = {
    timeout = 5;
    efi.canTouchEfiVariables = true;
    systemd-boot = {
      editor = false;
      consoleMode = "max";
      configurationLimit = 10;
    };
  };
}
