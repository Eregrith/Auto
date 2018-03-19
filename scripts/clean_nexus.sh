#!/bin/sh

declare -a Packages

continuationToken=

function getNextPage() {

	if [ -z $continuationToken ]
	then
		json=$(curl -s -X GET --header 'Accept: application/json' '$NEXUS_BASE_URL/service/siesta/rest/v1/assets?repositoryId=nuget-hosted')
	else
		json=$(curl -s -X GET --header 'Accept: application/json' "$NEXUS_BASE_URL/service/siesta/rest/v1/assets?repositoryId=nuget-hosted&continuationToken=$continuationToken")
	fi
	
	packagesString=$(echo "$json" | grep coordinates | cut -d '"' -f 4 | sed 's/\n/ /g')

	packagesToAdd=("$packagesString")
	
	Packages=("${Packages[@]}" "${packagesToAdd[@]}")
	
	continuationToken=$(echo "$json" | grep continuationToken | cut -d '"' -f 4)
}

function deletePackage() {
	package=$1
	
	echo "Deleting package $package on url: $NEXUS_BASE_URL/repository/nuget-hosted/$package"
	curl -s -X DELETE -u admin:admin123 "$NEXUS_BASE_URL/repository/nuget-hosted/$package"
}


if [ -z "$2" ] || [ "$2" != "--delete" ]
then
	echo "Looking for packages with name matching '$1'"
elif [ "$2" == "--delete" ]
then
	echo "Deleting packages with name matching '$1'"
fi

getNextPage
while ! [ -z $continuationToken ]
do
	getNextPage
done

echo "Packages corresponding to given pattern:"
echo ""
filteredPackages=( $(for package in ${Packages[@]} ; do echo $package; done | egrep $1) )
printf '%s\n' "${filteredPackages[@]}"

if [ -z "$2" ] || [ "$2" != "--delete" ]
then
	echo ""
	echo "Run this command to delete those packages:"
	echo "$0 $1 --delete"
elif [ "$2" == "--delete" ]
then
	for package in ${filteredPackages[@]}
	do
		deletePackage $package
	done
fi
