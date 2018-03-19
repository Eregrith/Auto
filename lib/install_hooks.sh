#!/bin/sh

wd=$(pwd)

cd ..
echo "Browsing repositories dirs:"
echo */

for dir in * ; do
	if [ -e $dir/.git ]; then
		cd $dir
		rm -rf .git/hooks
		echo "Adding symlink to $dir/.git/hooks -> Ast.Git/hooks"
		cmd //c "mklink /D .git\hooks ..\..\Ast.Git\hooks" >/dev/null
		cd ..
	fi
done

cd "$wd"
