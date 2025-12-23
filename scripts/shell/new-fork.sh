#!bin/bash

# Creates a new project folder and clones a project from my github.

# Define the variables:
notes_dir=$HOME/Documents/Notes/Projects
projects_dir=$HOME/Documents/Projects
project_name="$1"
project_template_dir=$HOME/Documents/Projects/scripting/scripts/project_template
tmuxp_template="$project_template_dir/project_initialization_template.tmuxp.yaml"
proj_tmux_template="$projects_dir/$project_name/.tmuxp.yaml"
pyproject_template="$project_template_dir/pyproject.toml"

# import the function library:
source $HOME/Documents/Projects/scripting/scripts/shell_func_lib/shell-funcs.sh


echo ""
create_folder "$notes_dir" "$project_name"
echo ""
create_folder "$notes_dir/$project_name" "Daily"
echo ""

# Create notes and todo files in Obsidian, then populate with template content.
nvim --headless -c "ObsidianNew Projects/$project_name/Notes.md" -c "w" -c "ObsidianNew Projects/$project_name/Tasks.md" -c "w" +qall 
echo ""
sleep 0.5
insert_file_contents_into_file "$project_template_dir/Notes.md" "$notes_dir/$project_name/Notes.md"
echo ""
sleep 0.5
insert_file_contents_into_file "$project_template_dir/Tasks.md" "$notes_dir/$project_name/Tasks.md"
echo ""
capitalized_project_name=$(capitalize_project_name "$project_name")
echo "$capitalized_project_name"
echo ""
sleep 0.5
replace_text_in_file "$notes_dir/$project_name/Notes.md" "Notes" "$capitalized_project_name"
echo ""
project_name_tasks_appended="$capitalized_project_name"" Tasks"
sleep 0.5
replace_text_in_file "$notes_dir/$project_name/Tasks.md" "Tasks" "$project_name_tasks_appended"
echo ""

# Create the project folder and initialize the tmuxp template.
#create_folder "$projects_dir" "$project_name"
cd "$projects_dir"
echo ""
#gh repo create $project_name --private --source=. --remote=upstream
gh repo clone $project_name

echo ""
cd "$projects_dir/$project_name"
touch "$projects_dir/$project_name/startup_files.txt"
sleep 0.5
copy_file "$tmuxp_template" "$proj_tmux_template"
echo ""
copy_file "$project_template_dir/.gitignore" "$projects_dir/$project_name/.gitignore"
copy_file "$project_template_dir/pyproject.toml" "$projects_dir/$project_name/pyproject.toml"
copy_file "$project_template_dir/.env" "$projects_dir/$project_name/.env"
copy_file "$project_template_dir/requirements.txt" "$projects_dir/$project_name/requirements.txt"
sleep 0.5
replace_text_in_file "$proj_tmux_template" "PROJECT_NAME" "$project_name"
#replace_text_in_file "$pyproject_template" "PROJECT_NAME" "$project_name"

echo ""
sleep 0.5
replace_project_name_formatted "$proj_tmux_template" "SESH_NAME" "$project_name"
replace_text_in_file "$projects_dir/$project_name/pyproject.toml" "PROJECT_NAME" "$project_name"

echo ""
echo ""
sleep 1

# Initialize the git repository locally and on GitHub.
#git init "$projects_dir/$project_name"
echo ""
cd "$projects_dir/$project_name"
devenv init
echo ""
devenv-replace
echo ""
#code-project-init

echo ""

echo ">>> Cloned project setup complete."
echo ""

# Open the project folder in the terminal in a clean state.
#clear

#zsh

#echo ""

#clear



