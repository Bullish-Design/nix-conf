#!bin/bash

# Opens all projects in the projects directory (to be run from g2w only)

# Import the function library:
#source $HOME/Documents/Projects/scripting/scripts/shell_func_lib/shell-funcs.sh
. import-shell-library

# Define the variables:
notes_dir=$HOME/Documents/Notes/Projects
projects_dir=$HOME/Documents/Projects
project_list_name=$1

## Run open project script for each project in the projects directory:
# run_script_in_subdirectories "$projects_dir" op

if [ -n "$project_list_name" ]; then
    project_list_file="$projects_dir/${project_list_name}.txt"
    
    if [ -f "$project_list_file" ]; then
        echo "Opening projects from list: $project_list_name"
        # Read directories from file and run op script in each
        # Using a different approach to ensure we catch the last line
        while read -r dir || [ -n "$dir" ]; do
            # Skip empty lines
            if [ -z "$dir" ]; then
                continue
            fi
            
            if [ -d "$projects_dir/$dir" ]; then
                echo "Opening project: $dir"
                run_script_in_matching_subdirectories "$projects_dir" op "$dir"
            else
                echo "Warning: Project directory not found: $dir"
            fi
        done < "$project_list_file"
    else
        echo "Project list file not found: $project_list_file"
        echo "Opening all projects instead..."
        run_script_in_subdirectories "$projects_dir" op
    fi
else
    # Run open project script for each project in the projects directory
    echo "No project list specified. Opening all projects..."
    run_script_in_subdirectories "$projects_dir" op
fi


# Resize all windows in the tmux session:
resize-windows

tmux send-keys -t "$project_list_name:1" "S-Right"

# Exit the initial tmux session:
# exit

# tmux send-keys -t Projects:1 ":! tmux select-window -t Projects:1" ENTER



