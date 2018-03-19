#!/bin/sh

mkdir temp

curl https://dist.nuget.org/win-x86-commandline/latest/nuget.exe --output temp/nuget.exe

mkdir -p "/c/Program Files (x86)/NuGet"

cp temp/nuget.exe "/c/Program Files (x86)/NuGet/"

#Adding NuGet to the path

export PATH="$PATH:/c/Program Files (x86)/NuGet";

rm temp/nuget.exe

#Remove temp if empty
rmdir temp 2> /dev/null