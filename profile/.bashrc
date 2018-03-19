#!/bin/sh

GIT_REPOS_DIR="REPLACE_ME"

# Loading git prompt config
source ~/.git_prompt

# Loading colors variables
source ~/.colors

#Adding GitVersion to the path
export PATH="$PATH:/c/Program Files/GitVersion";

alias reload="source ~/.bashrc"
alias gs="git status"
alias gk="gitk --all &"
alias vs="start *.sln"
alias gf="git fetch --prune"
alias winenv="rundll32 sysdm.cpl,EditEnvironmentVariables"
alias gd="git diff --word-diff"

export NEXUS_URL="http://ast-nexus:8081/repository/nuget-hosted/"

function npush() {
	package=$1
	nuget push $1 -Source $NEXUS_URL
}
alias npush=npush

function gitBranchInfos() {
	f=$1
	status=$(git --git-dir=$f.git --work-tree=$f status)
	branch=$(echo $status | grep "On branch " | cut -d ' ' --fields 3)
	if [ "$branch" == "" ]; then
		branch=$(echo $status | grep "You are currently rebasing branch" | cut -d "'" --fields 2)
	fi
	if [ "$branch" == "" ]; then
		branch=$(echo $status | grep "detached at" | cut -d " " --fields 4)
	fi
	echo $status | grep "Your branch is up-to-date" >/dev/null
	if [ $? -eq 0 ]; then
		uptodate="${GREEN}up-to-date${RESTORE}";
	else 
		echo $status | grep "Your branch is behind" >/dev/null
		if [ $? -eq 0 ]; then
			uptodate="${RED}behind${RESTORE}";
		else
			echo $status | grep "rebase" >/dev/null
			if [ $? -eq 0 ]; then
				next=$(cat $f/.git/rebase-apply/next)
				last=$(cat $f/.git/rebase-apply/last)
				uptodate="${YELLOW}rebasing $next/$last${RESTORE}"
			else
				echo $status | grep "detached" > /dev/null
				if [ $? -eq 0 ]; then
					uptodate="${MAGENTA}-detached-${RESTORE}";
				else
					uptodate="${RED}not pushed${RESTORE}";
				fi
			fi
		fi
	fi
	echo $status | grep "nothing to commit" >/dev/null
	if [ $? -eq 0 ]; then
		workdirstatus="${GREEN}clean${RESTORE}"
	else
		workdirstatus="${RED}dirty${RESTORE}"
	fi
	if [ "$branch" == "master" ]; then branch="${RED}$branch${RESTORE}";
	elif [ "$branch" == "develop" ]; then branch="${YELLOW}$branch${RESTORE}"; 
	elif [ "${branch:0:8}" == "feature/" -o "${branch:0:5}" == "tech/" ]; then branch="${GREEN}$branch${RESTORE}";
	elif [ "${branch}" == "integration" ]; then branch="${WHITE}$branch${RESTORE}";
	else branch="${MAGENTA}$branch${RESTORE}"; fi
	printf "%-50s %-25s %-25s" "$branch" "$uptodate" "$workdirstatus"
}

function lsgit() {
	for f in "$GIT_REPOS_DIR"/*/; do 
		
		if [ ! -e "$f/.git" ]; then continue; fi
		
		gitInfos=$(gitBranchInfos $f)
		f=$(basename "$f")
		f="${LBLUE}$f${RESTORE}"
		printf "%-50s %s\n" "$f" "$gitInfos"
	done
}

alias lsg=lsgit

function lspacks() {
	wd=$(pwd)
	for f in "$GIT_REPOS_DIR"/*/; do 
	
		if [ ! -e "$f/.git" ]; then continue; fi
		
		cd "$f"
		
		nuget_version=$(GitVersion | grep "NuGetVersionV2" | cut -d '"' --fields 4)
		
		f=$(basename "$f")
		f="${LBLUE}$f${RESTORE}"
		printf "%-50s -> %-50s\n" "$f" "$nuget_version"
	done
	cd "$wd"
}

alias lsp=lspacks

function lsfull() {
	wd=$(pwd)
	for f in "$GIT_REPOS_DIR"/*/; do 
	
		if [ ! -e "$f/.git" ]; then continue; fi
		
		gitInfos=$(gitBranchInfos $f)
		cd "$f"
		nuget_version=$(GitVersion | grep "NuGetVersionV2" | cut -d '"' --fields 4)
		f=$(basename "$f")
		f="${LBLUE}$f${RESTORE}"
		printf "%-50s %s Version: %-50s\n" "$f" "$gitInfos" "$nuget_version"
	done
	cd "$wd"
}

alias lsf=lsfull

function set_title() {
	echo -ne "\e]0;$1\a"
}
function extranet_log() {
	set_title "Logs Extranet Fournisseurs"
	less +F $GIT_REPOS_DIR/Ast.Extranet.Fournisseurs/Ast.Extranet.Fournisseurs.CMS/ExtranetFournisseur.log
}
function api_server_log() {
	set_title "Logs API Server"
	less +F $GIT_REPOS_DIR/Ast.Extranet.Api.Server/Ast.Extranet.Api.Server/ApiServer.log
}

alias extlog=extranet_log
alias apilog=api_server_log

cd "$GIT_REPOS_DIR"

cd Ast.Git
status=$(git status)
echo $status | grep "Your branch is up-to-date" >/dev/null
if [ $? -eq 0 ]; then
	echo $status | grep "nothing to commit" >/dev/null
	if [ $? -eq 0 ]; then
		git checkout master >/dev/null
		git pull >/dev/null
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
