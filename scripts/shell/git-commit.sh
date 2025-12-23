# A function to automate Git actions: add, commit and push. Provide a branch name and commit message as arguments. 

# Check if the user provided the branch name and commit message as arguments
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <branch_name> <commit_message>"
  exit 1
fi

branch_name="$1"
commit_message="$2"

# Function to check if there are any changes to commit
check_changes() {
  if [ -z "$(git status --porcelain)" ]; then
    echo "No changes to commit."
    exit 0
  fi
}

# Function to add changes, commit and push
commit_and_push() {
  git add .
  echo ""
  git status
  echo
  echo
  git commit -m "$commit_message"
  echo 
  echo
  git push "$branch_name" main
}

# Main script logic
echo ""
echo ">>> Executing script to automate Git actions..."
echo ""

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
commit_and_push

echo ""
echo ">>> Changes committed and pushed successfully to the $branch_name branch."
echo ""
