#!/bin/sh
GIT_REPOS_DIR="REPLACE_ME"
# YOUR OWN CONFIG UNDER THIS LINE








#END OF YOUR OWN CONFIG


#Updating the auto.git.config
cd "$GIT_REPOS_DIR"
cd Auto.Git
status=$(git status)
echo $status | grep "Your branch is up-to-date" >/dev/null
if [ $? -eq 0 ]; then
	echo $status | grep "nothing to commit" >/dev/null
	if [ $? -eq 0 ]; then
		git checkout master >/dev/null
		git pull >/dev/null
		./lib/update_auto_git_config.sh
	fi
fi
cd ..

echo "                                                                     "
echo "                                                                     "
echo "                    WELCOME !                                        "
echo "                                                                     "
echo "   HERE ARE YOUR BRANCHES STATUS:                                    "
echo "                                                                     "
echo "                                                                     "
lsfull

echo
echo
