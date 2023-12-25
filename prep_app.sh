#!/bin/bash

if [ $# -ne 1 ]; then
  echo "Usage: $0 <version_number>"
  exit 1
fi

VERSION=$1
REPO_URL="https://github.com/johnpapa/node-hello"
README_URL="https://raw.githubusercontent.com/LamdatOrg/DevOps-Candidate-Test/main/README.md"
APP_DIR="node-hello"

# Clone the repository
git clone $REPO_URL $APP_DIR || { echo "Failed to clone repository"; exit 1; }

# Change directory to the app root
cd $APP_DIR || { echo "Failed to access app directory"; exit 1; }

# Update the app version
jq ".version = \"$VERSION\"" package.json > temp.json && mv temp.json package.json || { echo "Failed to update version"; exit 1; }

# Download README.md
wget -O README.md $README_URL || { echo "Failed to download README.md"; exit 1; }

# Zip the app folder
cd ..

zip -r "app-$VERSION.zip" $APP_DIR/* || { echo "Failed to zip the app folder"; exit 1; }

echo "Task completed: app-$VERSION.zip created successfully."
