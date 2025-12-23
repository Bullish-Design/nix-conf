#!/bin/bash

# A script to replace the initial devenv.nix file with a modular template file, then perform some text replacement to finish up. 

# Import the function library:
#source $HOME/scripts/shell/lib.sh 
. import-shell-library

# Define the variables:
devenv_template_directory=$HOME/Documents/Projects/scripting/scripts/project_template/devenv
replacement_directory=$devenv_template_directory/replacement_templates
devenv_template=$HOME/Documents/Projects/scripting/scripts/project_template/devenv/devenv.nix
current_directory=$(pwd)
current_devenv_file=$current_directory/devenv.nix
proj_name=$(basename $current_directory)
formatted_proj_name=$(format_name $proj_name)


# Define the replacement files:
envvars=$replacement_directory/envvars.nix
packages=$replacement_directory/packages.nix
languages=$replacement_directory/languages.nix
processes=$replacement_directory/processes.nix
services=$replacement_directory/services.nix
scripts=$replacement_directory/scripts.nix
pre_commit_hooks=$replacement_directory/pre_commit_hooks.nix

echo "------------------- Initalizing devenv.nix file -------------------"
# Replace the initial devenv.nix file with the modular template file.
copy_file $devenv_template $current_devenv_file

# Replace the text in the new devenv.nix file:
replace_text_with_nix_file_content "$current_devenv_file" "#LANGUAGES_INIT" "$languages"

# Replace specific text:
replace_text_in_file "$current_devenv_file" "#PROJ_NAME" "$formatted_proj_name"





echo "-------------------------------------------"


