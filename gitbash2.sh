#!/bin/bash

# Check if 'gh' command is available
if ! command -v gh &> /dev/null; then
    echo "Error: 'gh' command not found. Please install GitHub CLI."
    exit 1
fi

# Ask for the directory name
read -p "Enter the directory name: " DIRECTORY_NAME

# Check if the directory already exists
if [ -d "$DIRECTORY_NAME" ]; then
    echo "Directory already exists. Changing into existing directory."
else
    # Create a new directory if it doesn't exist
    mkdir "$DIRECTORY_NAME" || { echo "Error: Could not create directory."; exit 1; }
fi

# Change into the directory
cd "$DIRECTORY_NAME" || { echo "Error: Could not change to the directory."; exit 1; }

# Initialize a Git repository
git init || { echo "Error: Could not initialize Git repository."; exit 1; }

# Prompt for repository visibility (private or public)
read -p "Enter 'private' or 'public' for repository visibility: " GITHUB_REPO_VISIBILITY

# Validate input for repository visibility
if [ "$GITHUB_REPO_VISIBILITY" != "private" ] && [ "$GITHUB_REPO_VISIBILITY" != "public" ]; then
    echo "Error: Invalid input for repository visibility. Please enter 'private' or 'public'."
    exit 1
fi

# Create the GitHub repository using 'gh' command-line tool
gh repo create "$GITHUB_REPO_NAME" --$GITHUB_REPO_VISIBILITY --source=. --remote=origin || { echo "Error: Could not create GitHub repository."; exit 1; }

# Rename the default branch to 'main'
git branch -M main

# Create a sample file (you can replace this with your files)
echo "Hello, World!" > sample.txt

# Add all files to the Git repository
git add .

# Commit the changes
git commit -m "Initial commit"

# Push the code to the GitHub repository
git push --set-upstream origin main || { echo "Error: Could not push to GitHub repository."; exit 1; }
