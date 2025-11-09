#!/bin/bash

SUBMODULE_PATH="better-mflowgen"
SUBMODULE_URL="https://github.com/thedubbers9/better-mflowgen-repo.git"

# Check if the submodule already exists (listed in .gitmodules)
if git config --file .gitmodules --get-regexp path | grep -q "$SUBMODULE_PATH"; then
  echo "Submodule '$SUBMODULE_PATH' already exists. Skipping add."
else
  echo "Adding submodule '$SUBMODULE_PATH'..."
  git submodule add "$SUBMODULE_URL" "$SUBMODULE_PATH"
  git submodule update --init --recursive "$SUBMODULE_PATH"
  echo "Submodule added successfully."
fi

## run better-mflowgen setup script
cd better-mflowgen
source run_setup.sh
cd ..

alias better_mflowgen='python3 $(pwd)/better-mflowgen/automated_run.py'
