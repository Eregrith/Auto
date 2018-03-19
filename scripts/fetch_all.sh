#!/bin/sh

wd=$(pwd)

echo "Fetching all in $GIT_REPOS_DIR ..."
cd "$GIT_REPOS_DIR"

for i in *; do
	if [[ -e "$i/.git" ]]; then
		cd $i
		git fetch --prune
		cd - > /dev/null
	fi
done

echo "Done."

cd $wd;