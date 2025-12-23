#!/bin/bash

# A script to open a specific set of project folders and initialize their devenv environments.

# Import the function library: 
. import-shell-library

# Define the variables:
notes_dir=$HOME/Documents/Notes/Projects
projects_dir=$HOME/Documents/Projects


# Navigate to the projects directory:
cd $projects_dir

run_script_group() {
    source import-shell-library
    projects_dir=$HOME/Documents/Projects

    cd "$projects_dir"
    echo "Running project scripts..."
    run_script_in_matching_subdirectories "$projects_dir" op-dev "$@"
}

echo "Getting ready to run the script group..."
echo ""
# The $@ variable expands to all command-line arguments
#tmux new -s Scripts "$(declare -f run_script_group); run_script_group $@"
tmux new -s Scripts bash -c '
    # Import the function library
    source import-shell-library

    # Define the variables
    projects_dir="$HOME/Documents/Projects"

    # Call the function with the necessary arguments
    run_script_in_matching_subdirectories "$projects_dir" op-dev "$@"
' bash "$@"

# sleep 5
# # Send keys to the tmux session:
# tmux send-keys -t "Scripts:1" C-j
# sleep 1
# tmux send-keys -t "Scripts:1" dev-boot
# sleep 5
# tmux send-keys -t "Scripts:1" main
# sleep 1
# tmux send-keys -t "Scripts:1" "S-Right"
# sleep 1
# tmux send-keys -t "Scripts:2" C-j
# sleep 1
# tmux send-keys -t "Scripts:2" dev-boot
# sleep 5
# tmux send-keys -t "Scripts:2" main