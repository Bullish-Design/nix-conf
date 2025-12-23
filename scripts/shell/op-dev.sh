#!/bin/bash

# Calls the tmuxp load command for the current directory. Then runs dev-boot, then runs main.

echo ""
echo "Running OP-Dev"
echo ""

tmuxp load -a .

# exit
# #sleep 5

# echo "Sending Keys..."
# # Move down to 
# tmux send-keys C-j

# echo "Booting Dev environments..."
# # Initialize any development environments
# dev-boot

# # Make a call to main to run the main script
# main
