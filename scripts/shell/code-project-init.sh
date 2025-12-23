#!/bin/bash

# A script to bootstrap a code project.

# Import the function library: 
. import-shell-library

# Define the variables:
devenv_template_directory=$HOME/Documents/Projects/scripting/scripts/project_template/devenv
replacement_directory=$devenv_template_directory/replacement_templates
devenv_template=$HOME/Documents/Projects/scripting/scripts/project_template/devenv/devenv.nix
project_template=$HOME/Documents/Projects/scripting/scripts/project_template/ROOT_FOLDER
current_directory=$(pwd)
current_devenv_file=$current_directory/devenv.nix
proj_name=$(basename $current_directory)
formatted_proj_name=$(format_name $proj_name)


echo ""
echo "------------------- Initalizing code project -------------------"
echo ""

#create_folder "$current_directory" "$proj_name"
copy_folder "$project_template" "$current_directory"

rename_folder "$current_directory/ROOT_FOLDER" "$current_directory/$proj_name"


#create_folder "$current_directory/$proj_name" "src"
#create_folder "$current_directory/$proj_name" "tests"
#create_folder "$current_directory/$proj_name" "logs"
#create_folder "$current_directory/$proj_name" "logs/log"

#dev-boot
# uv pip install typer
#uv pip install result
#uv pip install python-dotenv

#uv pip freeze > requirements.txt

#dev-boot





echo "------------------- Initialization Complete ------------------------"
echo ""

