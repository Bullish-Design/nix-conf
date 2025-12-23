#!bin/bash

# Define the variables:
notes_dir=$HOME/Documents/Notes/Projects
projects_dir=$HOME/Documents/Projects
project_name="$1"
project_template_dir=$HOME/Documents/Projects/scripting/scripts/project_template
tmuxp_template="$project_template_dir/project_initialization_template.tmuxp.yaml"
proj_tmux_template="$projects_dir/$project_name/.tmuxp.yaml"

# import the function library:
source $HOME/Documents/Projects/scripting/scripts/shell_func_lib/shell-funcs.sh


echo ""
create_folder "$notes_dir" "$project_name"
echo ""

echo ""
# copy_files "$project_template_dir" "$notes_dir/$project_name" "Notes.md" "ToDo.md"

nvim --headless -c "ObsidianNew Projects/$project_name/Notes.md" -c "w" -c "ObsidianNew Projects/$project_name/ToDo.md" -c "w" +qall 

echo ""



