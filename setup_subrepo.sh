#!/bin/bash

SUBMODULE_PATH="better-mflowgen"
SUBMODULE_URL="https://github.com/thedubbers9/better-mflowgen-repo.git"

UPDATE_ONLY=false

# Parse command-line options
while getopts "u" opt; do
  case $opt in
    u)
      UPDATE_ONLY=true
      ;;
    *)
      echo "Usage: $0 [-u]"
      echo "  -u   Update submodule to latest origin commit"
      exit 1
      ;;
  esac
done

# Function to determine the current branch of the submodule
get_submodule_branch() {
  cd "$SUBMODULE_PATH" || exit 1
  BRANCH=$(git symbolic-ref --short HEAD 2>/dev/null || echo "main")
  cd - >/dev/null
  echo "$BRANCH"
}

# Function to update the submodule
update_submodule() {
  if [ -d "$SUBMODULE_PATH" ]; then
    BRANCH=$(get_submodule_branch)
    echo "🔄 Updating '$SUBMODULE_PATH' on branch '$BRANCH'..."
    cd "$SUBMODULE_PATH" || exit 1
    git fetch origin "$BRANCH"
    git checkout "$BRANCH"
    git pull origin "$BRANCH"
    cd - >/dev/null
    git add "$SUBMODULE_PATH"
    git commit -m "Update $SUBMODULE_PATH submodule to latest $BRANCH" || true
    echo "Submodule updated to latest commit on '$BRANCH'."
  else
    echo "Submodule directory '$SUBMODULE_PATH' not found. Run without -u first."
    exit 1
  fi
}

# If -u passed, update submodule first
if [ "$UPDATE_ONLY" = true ]; then
  update_submodule
fi

# Check if submodule exists, otherwise add it
if git config --file .gitmodules --get-regexp path | grep -q "$SUBMODULE_PATH"; then
  echo "Submodule '$SUBMODULE_PATH' already exists. Skipping add."
else
  echo "Adding submodule '$SUBMODULE_PATH'..."
  git submodule add "$SUBMODULE_URL" "$SUBMODULE_PATH"
  echo "Submodule added successfully."
fi

git submodule update --init --recursive "$SUBMODULE_PATH"

# Check if mflowgen is on the user's PATH
if ! command -v mflowgen &> /dev/null; then
  echo "'mflowgen' not found in PATH. Running setup script..."
  cd "$SUBMODULE_PATH" || exit 1
  source run_setup.sh
  cd - >/dev/null
else
  echo "'mflowgen' already available on PATH. Skipping setup."
fi

# Define alias for convenience (only for current shell)
alias better_mflowgen='python3 $(pwd)/better-mflowgen/automated_run.py'

echo "Setup complete. You can now run 'better_mflowgen' directly."
