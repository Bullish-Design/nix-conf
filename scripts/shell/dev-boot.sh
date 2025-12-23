#!bin/bash

# Starts up devenv servers, etc in the background, then starts the shell.

set -euo pipefail

# ------------------------------------------------------------------
# 1.  Resolve project name from the caller’s working directory.
#     - $(pwd) gives the full path you invoked the script from
#     - basename strips it down to just the leaf directory name
# ------------------------------------------------------------------
PROJECT_NAME="$(basename "$(pwd)")"

# 2.  Build a consistent log directory under XDG (or fallback)
LOG_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/${PROJECT_NAME}"
mkdir -p "$LOG_DIR"

LOG_FILE="${LOG_DIR}/${PROJECT_NAME}_devenv.log"

# ------------------------------------------------------------------
# 3.  Start/attach to the devenv service layer completely detached
#     - stdin from /dev/null prevents TTY output → no SIGTTOU suspends
#     - stdout/err redirected to the per-project log we just built
# ------------------------------------------------------------------
export PROCESS_COMPOSE_TUI=0
export PC_DISABLE_TUI=1
stty -tostop

devenv up -d < /dev/null >"$LOG_FILE" 2>&1 & disown

sleep 1  # Give it a moment to start up

# 4.  Replace the current shell with the devenv environment
exec -c devenv shell zsh
#devenv shell zsh