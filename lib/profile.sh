#!/bin/sh

echo "Configuration of bash profile files"

cd .. 
GIT_REPO_DIR=$(pwd)
cd -

cp profile/.* ~/ 2>/dev/null
cp profile/* ~/ 2>/dev/null

sed -i -- "s~REPLACE_ME~$GIT_REPO_DIR~" ~/.bashrc