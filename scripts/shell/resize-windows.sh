#!bin/bash

# A script to cycle through each open Tmux window and send a command to each one.

# Import the script library:
source $HOME/Documents/Projects/scripting/scripts/shell_func_lib/shell-funcs.sh

#resize_tmux_panes

# Get the currently active Tmux session
active_session=$(tmux display-message -p '#S')

# Get the list of windows in the active session
windows=$(tmux list-windows -t "$active_session" -F '#I')

for window_id in $windows; do
    echo "Sending resize window command to window $window_id in session $active_session"
    # sleep 0.5
    tmux select-window -t "$active_session:$window_id"
    # sleep 0.5
    tmux resizep -y 90% #\; send-keys 'C-Down'
    # sleep 0.5

    # tmux send-keys "S-Right" C-Down
done
# tmux send-keys -t "Projects.1" "S-Right"
#tmux select-window -t "$active_session:${windows[0]}"


