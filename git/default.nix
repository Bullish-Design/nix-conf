{
  programs.git = {
    enable = true;
    userName = "Bullish Design";
    userEmail = "BullishDesignLLC@gmail.com"; # CHANGEME
    
    delta = {
      enable = true;
      options = {
        navigate = true;
        side-by-side = true;
      };
    };

    extraConfig = {
      init.defaultBranch = "main";
      # Automatically track remote branch
      push.autoSetupRemote = true;
      pull = { rebase = false; };
      merge = {
        conflictStyle = "zdiff3";
      };
      #core.pager = "delta";


      credential.helper = "!gh auth git-credential";

      # Optional but common if you prefer HTTPS:
      # url."https://github.com/".insteadOf = "git@github.com:";
      # url."https://github.com/".insteadOf = "ssh://git@github.com/";
    };
  };
}
