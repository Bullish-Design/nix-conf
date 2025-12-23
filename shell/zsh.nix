{ pkgs, lib, config, ... }: 

{

  home.packages = with pkgs; [ eza bat ripgrep tldr ];

  
  ## 2️⃣ make sure Oh-My-Zsh looks in that folder first
  #programs.zsh.sessionVariables.ZSH_CUSTOM =
  #  "${config.home.homeDirectory}/.oh-my-zsh/custom";


  programs.zsh = {
    enable = true;

    # initContent = lib.mkBefore ''
    #   setopt INTERACTIVE_COMMENTS # allow comments in interactive mode
    #   '';
      
    enableCompletion = true;

    autosuggestion = {
      enable = true;
      highlight = "fg=248,italic,underline";
    };

    syntaxHighlighting = {
      enable = true;
      styles = {
        comment = "fg=white,bold,underline";
        # string = "bold";
        # parameterExpansion = "bold";
        # commandSubstitution = "bold";
        # substitutionPromptBegin = "bold";
        # substitutionPromptEnd = "bold";
        # variable = "bold";
      };
    };

    historySubstringSearch.enable = true;

    history = {
      # ignoreDups = true;
      append = true;
      save = 1000000;
      size = 1000000;
    };

    oh-my-zsh = {
      enable = true;
      # theme = "af-magic";
      custom  = "${config.home.homeDirectory}/.oh-my-zsh/custom";  # <─ sets ZSH_CUSTOM early
    
      theme = "devprompt";

      plugins = [ 
        "git" 
        "virtualenv"
        ];
    };

    profileExtra = lib.optionalString (config.home.sessionPath != [ ]) ''
      export PATH="$PATH''${PATH:+:}${
        lib.concatStringsSep ":" config.home.sessionPath
      }"
    '';

    shellAliases = {
      vim = "nvim";
      v = "nvim";
      c = "clear";
      clera = "clear";
      celar = "clear";
      e = "exit";
      cd = "z";

      ls = "${pkgs.eza}/bin/eza --icons=always";
      sl = "ls";
      open = "${pkgs.xdg-utils}/bin/xdg-open";
      icat = "${pkgs.kitty}/bin/kitty +kitten icat";
    };

    initContent = ''
      export PATH="$HOME/.local/bin:$PATH"
      export DISABLE_AUTO_TITLE="true"

      setopt INTERACTIVE_COMMENTS

      # Make sure add-zsh-hook is available
      autoload -Uz add-zsh-hook

      _atuin_comment_history() {
        emulate -L zsh

        # strip trailing newline (the ''${ escapes Nix interpolation)
        local line=''${1%%$'\n'}

        [[ $line == \#* ]] || return 0    # ignore non-comment lines

        print -sr -- "$line"              # keep it in normal history

        {
          local id=$(ATUIN_LOG=error atuin history start -- "$line")   # open row 
          ATUIN_LOG=error atuin history end --exit 0 --duration=0 -- "$id"   # close row 
        } &!                            # fire-and-forget, like upstream Atuin
      }

      add-zsh-hook zshaddhistory _atuin_comment_history
    '';
  };


  # 1️⃣ write the file
  home.file.".oh-my-zsh/custom/themes/devprompt.zsh-theme".source = ./devprompt.zsh-theme;

}
