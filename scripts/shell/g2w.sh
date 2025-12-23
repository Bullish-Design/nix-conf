#!bin/bash

# Opens all projects in the projects directory in a new tmux session.

# Import the function library:
#source $HOME/Documents/Projects/scripting/scripts/shell_func_lib/shell-funcs.sh
. import-shell-library

# Define the variables:
notes_dir=$HOME/Documents/Notes/Projects
projects_dir=$HOME/Documents/Projects
project_list=$1
session_name=$project_list

#source $HOME/.venvs/neovim/bin/activate

echo "Creating a new tmux session: $session_name"

# Navigate to the projects directory:
cd $projects_dir

# Start a new tmux session:
#tmux new -s Projects open-all-projects
tmux new -s $project_list open-all-projects "$project_list"

# sleep 0.5

# Try to navigate to the first window in the tmux session:
# tmux send-keys -t Projects:1 ":! tmux select-window -t Projects:1" ENTER
#tmux send-keys S-Right 

# Hope it works?
