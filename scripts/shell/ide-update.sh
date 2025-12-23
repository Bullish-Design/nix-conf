# Script for updating IDE. Switches to directory, updates git, and runs nixos-rebuild. Provide commit message as argument.

# Check if the user provided the branch name and commit message as arguments
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <commit_message>"
  exit 1
fi

# branch_name="$1"
commit_message="$1"

# Function to check if there are any changes to commit
check_changes() {
  if [ -z "$(git status --porcelain)" ]; then
    echo "No changes to commit."
    exit 0
  fi
}

# Function to add changes, commit and push
commit_and_push_IDE() {
  git add .
  echo ""
  git status
  echo
  echo

  git commit -m "$commit_message"
  echo
  echo
  git push IDE main
}

commit_and_push_nix() {
  git add .
  echo ""
  git status
  echo
  echo

  git commit -m "$commit_message"
  echo
  echo
  git push nix main
}

# Main script logic
echo ""
echo ">>> Executing script to update IDE."
echo ""

echo ""
echo ">>> Changing to IDE directory, pushing to git..."
echo ""


cd $HOME/Documents/Projects/IDE

# Ensure the current directory is a Git repository
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "Error: Current directory is not a Git repository."
  exit 1
fi

# Switch to the specified branch
# git checkout "$branch_name"

# Check for changes and proceed accordingly
check_changes

# Perform the commit and push
commit_and_push_IDE

echo ""
echo ">>> Changing to nix directory, pushing to git..."
echo ""

cd $HOME/.dotfiles

# Updating flake 
nix flake update
echo ""
# Ensure the current directory is a Git repository
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "Error: Current directory is not a Git repository."
  exit 1
fi

check_changes
echo ""
commit_and_push_nix

echo ""
echo ">>> Changes committed and pushed successfully to git."
echo ""
