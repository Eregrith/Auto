#!/bin/sh

GREEN="\033[0;32m"
RESTORE="\033[0m"

echo "Starting main global config of git..."
echo 
echo "When pulling, rebase instead of merge"
git config --global pull.rebase merges
echo 
echo "Disabling merge fast-forward by default"
git config --global merge.ff false
echo 
echo "Changing the color of upstream branches to magenta (for readability of git branch -avv)"
git config --global color.branch.upstream magenta
echo 
echo "Activation de rerere: Reuse Recorded Resolution"
git config --global rerere.enabled true
echo
echo "Creating aliases ..."
echo 
git config --global alias.tree "log --all --decorate --oneline --graph"
git config --global alias.recommit "commit --amend --no-edit"
