{ pkgs, lib, config, ... }: {

  home.packages = with pkgs; [
    # A script to bootstrap a code project.
    (writeShellScriptBin "code-project-init" (builtins.readFile ./code-project-init.sh))

    # Define the variables:
    (writeShellScriptBin "create_save" (builtins.readFile ./create_save.sh))

    # Starts up devenv servers, etc in the background, then starts the shell.
    (writeShellScriptBin "dev-boot" (builtins.readFile ./dev-boot.sh))

    # A script to replace the initial devenv.nix file with a modular template file, then perform some text replacement to finish up. 
    (writeShellScriptBin "devenv-replace" (builtins.readFile ./devenv-replace.sh))

    # A script to be run at the start of the development environment. Mostly says hello in a nicely formatted way.
    (writeShellScriptBin "devenv-startup" (builtins.readFile ./devenv-startup.sh))

    # Opens a list of files from a .txt file 
    (writeShellScriptBin "filelist-open" (builtins.readFile ./filelist-open.sh))

    # Opens all projects in the projects directory in a new tmux session.
    (writeShellScriptBin "g2w" (builtins.readFile ./g2w.sh))

    # A function to automate Git actions: add, commit and push. Provide a branch name and commit message as arguments. 
    (writeShellScriptBin "git-commit" (builtins.readFile ./git-commit.sh))

    # Script for updating IDE. Switches to directory, updates git, and runs nixos-rebuild. Provide commit message as argument.
    (writeShellScriptBin "ide-update" (builtins.readFile ./ide-update.sh))

    # A script to import the shell library into other shell functions. 
    (writeShellScriptBin "import-shell-library" (builtins.readFile ./import-shell-library.sh))

    # Creates a new project folder and clones a project from my github.
    (writeShellScriptBin "new-fork" (builtins.readFile ./new-fork.sh))

    # Creates a new project folder when given a project name as argument.
    (writeShellScriptBin "new-project" (builtins.readFile ./new-project.sh))

    # Pushes a new commit with all changed files to the website repo.  
    (writeShellScriptBin "notes-update" (builtins.readFile ./notes-update.sh))

    # Calls the tmuxp load command for the current directory. Then runs dev-boot, then runs main.
    (writeShellScriptBin "op-dev" (builtins.readFile ./op-dev.sh))

    # Opens all projects in the projects directory (to be run from g2w only)
    (writeShellScriptBin "open-all-projects" (builtins.readFile ./open-all-projects.sh))

    # Performs all initialization functionality when opening a project folder.
    (writeShellScriptBin "open-project" (builtins.readFile ./open-project.sh))

    # Just calls the tmuxp load command for the current directory.
    (writeShellScriptBin "op" (builtins.readFile ./op.sh))

    # A script to cycle through each open Tmux window and send a command to each one.
    (writeShellScriptBin "resize-windows" (builtins.readFile ./resize-windows.sh))

    # A script to run a devenv script in a detached terminal instance:
    (writeShellScriptBin "run-project-script" (builtins.readFile ./run-project-script.sh))

    # A script to open a specific set of project folders and initialize their devenv environments.
    (writeShellScriptBin "run-proj" (builtins.readFile ./run-proj.sh))

    # Creates built-in shell functions for each shell script in the scripts folder.
    (writeShellScriptBin "update-nix-scripts" (builtins.readFile ./update-nix-scripts.sh))

    # Pushes a new commit with all changed files to the website repo.  
    (writeShellScriptBin "website-update" (builtins.readFile ./website-update.sh))

  ];

}

