#!/bin/bash

#Ask for the directory name
read -p "Enter the directory name: " DIRECTORY_NAME

# Ask for the GitHub repository name
read -p "Enter the GitHub repository name: " GITHUB_REPO_NAME

# Create a new directory
mkdir "$DIRECTORY_NAME"

# Change into the new directory
cd "$DIRECTORY_NAME"

# Initialize a Git repository
git init

# Prompt for repository visibility (private or public)
read -p "Enter 'private' or 'public' for repository visibility: " GITHUB_REPO_VISIBILITY

# Create the GitHub repository using 'gh' command-line tool
gh repo create "$GITHUB_REPO_NAME" --$GITHUB_REPO_VISIBILITY --source=. --remote=origin

# Rename the default branch to 'main'
git branch -M main

# Create a sample file (you can replace this with your files)
echo "Hello, World!" > sample.txt

# Add all files to the Git repository
git add .

# Commit the changes
git commit -m "Initial commit"

# Push the code to the GitHub repository
git push --set-upstream origin main
