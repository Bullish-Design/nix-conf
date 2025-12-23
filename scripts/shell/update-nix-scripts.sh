#!bin/bash

# Creates built-in shell functions for each shell script in the scripts folder.

# import the function library:
source $HOME/Documents/Projects/scripting/scripts/shell_func_lib/shell-funcs.sh

script_folder="$HOME/Documents/Projects/scripting/scripts/shell"
output_folder="$HOME/.dotfiles/scripts/shell"
output_file="$output_folder/scripts.nix"

echo ""
echo ">>> Executing script to create NixOS scripts file..."
echo ""

# Need to add something here to clear out the existing files in the output folder:


# Copy all shell files to the scripts dotfiles folder
copy_shell_files "$script_folder" "$output_folder"

# Create the nixos scripts file
create_nixos_scripts_file "$script_folder" "$output_file"

echo ""
echo ">>> Script complete."
echo ""








