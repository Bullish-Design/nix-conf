#!bin/bash

# Performs all initialization functionality when opening a project folder.

# Import the function library:
source $HOME/Documents/Projects/scripting/scripts/shell_func_lib/shell-funcs.sh


# Define the variables:
decimal_date=$(date +"%y-%V-%u")
decimal_year=$(date +"%y")
decimal_week=$(date +"%V")
decimal_day=$(date +"%u")
notes_dir=$HOME/Documents/Notes/Projects
current_project_dir=$(basename "$(pwd)")

echo ""
echo "Decimal Date: $decimal_date"
echo ""
echo ">>> Check for and create the daily notes file..."
echo ""

file_exists "$notes_dir/$current_project_dir/Daily/$decimal_date.md" || return 1

session_name="NVIM_SESSION_$current_project_dir"
SESSION_VAR=$session_name"_NOTES"
#script="terminal tmux setenv $SESSION_VAR"

if [ $? -eq 0 ]; then
  echo ""
  echo ">>> Daily notes file already exists. Carrying on..."
  echo ""
  nvim --cmd ":execute '!tmux setenv $SESSION_VAR ' . v:servername"  "Notes.md" "Tasks.md" "$notes_dir/$current_project_dir/Daily/$decimal_date.md"
  echo ""
  # sleep 0.1
#   tmuxp load .
else
  echo ""
  echo ">>> Creating the daily notes file..."
  echo ""
  #nvim --cmd "execute 'terminal tmux setenv $SESSION_VAR' v:servername"  -cmd "sleep 1" -cmd 'call nvim_feedkeys("\<CR>")'  "Notes.md" "Tasks.md" -c "ObsidianNew Projects/$current_project_dir/Daily/$decimal_date.md" -c "w"
  nvim --cmd ":execute '!tmux setenv $SESSION_VAR ' . v:servername"  "Notes.md" "Tasks.md" -c "ObsidianNew Projects/$current_project_dir/Daily/$decimal_date.md" -c "w"
 
  echo ""
  echo ">>> Daily notes file created and opened."
  echo ""
  # sleep 0.1
fi




