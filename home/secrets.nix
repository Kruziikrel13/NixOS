{
  services.ssh-agent.enable = true;
  services.gpg-agent.enable = true;
  programs.gpg.enable = true;
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    matchBlocks = {
      "github" = {
        hostname = "github.com";
        user = "kruziikrel13";
      };
    };
  };
}
