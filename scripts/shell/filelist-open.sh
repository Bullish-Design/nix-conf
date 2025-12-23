#!bin/bash

# Opens a list of files from a .txt file 
file_list="$1"
project_name="$2"

# Import the function library:
source $HOME/Documents/Projects/scripting/scripts/shell_func_lib/shell-funcs.sh



echo ""
open_files_in_nvim "$file_list" "$project_name"
echo ""
