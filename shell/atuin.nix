{ config, ... }: {
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    # enableBashIntegration = true;

    flags = [ "--disable-up-arrow" ];

    settings = {
      auto_sync = true;
      sync_frequency = "1m";
      sync_address = "https://api.atuin.sh";

      # Uncomment this to use your instance
      # sync_address = "https://test-instance.fly.dev";
    };
  };
}