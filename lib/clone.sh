#!/bin/sh

GIT_DIR=".."
REPO_FILE="lib/repos.sh"

source $REPO_FILE

echo "Cloning all AST repositories into $GIT_DIR"

wd=$(pwd)

cd $GIT_DIR

for repo in "${!REPOS[@]}"; do
	if [ ! -d $repo ]; then
		echo "Cloning $repo with URL : ${REPOS[$repo]}"
		git clone ${REPOS[$repo]} 2>/dev/null
	fi
done
