#!bin/bash

# A script to be run at the start of the development environment. Mostly says hello in a nicely formatted way.

project_name="$1"

echo ""
echo "--------------------------------------------------"
echo ""
echo "Starting the development environment for $project_name"
echo ""
uv pip install -r requirements.txt
echo ""
echo "--------------------------------------------------"
echo ""


