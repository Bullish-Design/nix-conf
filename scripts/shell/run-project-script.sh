#!/bin/bash

# A script to run a devenv script in a detached terminal instance:

. import-shell-library

folder="$1"
script="$2"

run_script_in_folder "$folder" "$script"



