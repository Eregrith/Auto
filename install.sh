#!/bin/sh

./lib/profile.sh
./lib/gitversion.sh
./lib/config.sh
#./lib/clone.sh
#./lib/install_hooks.sh

source ~/.bashrc

echo "Many aliases are available now :"
echo "git aliases:"
echo -e "${GREEN}git tree${RESTORE} = visual history as a tree"
echo -e "${GREEN}git recommit${RESTORE} = amend previous commit without editing the commit message"
echo
echo "Bash aliases:"
echo -e "${GREEN}lsg${RESTORE} = show your git dir's repositories states"
echo -e "${GREEN}lsp${RESTORE} = show your git dir's repositories current versions"
echo -e "${GREEN}lsf${RESTORE} = both of the above"
echo

echo "To complete install, you should ${YELLOW}reload bash config${RESTORE} through"
echo
echo "${WHITE}source ~/.bashrc${RESTORE}"
echo 
echo "Or just close and reopen Git Bash"
echo
echo -e "You can work then. ${RED}Do not forget about creating a branch for your work${RESTORE} with"
echo
echo "${WHITE}git checkout -b ${GREEN}{branch name}${RESTORE}"
echo
echo "With branch name starting with the type of branch, for example :"
echo
echo "${GREEN}tech${RESTORE}/Refactoring_User_Log_In for a ${GREEN}technical branch${RESTORE}"
echo "${MAGENTA}feature${RESTORE}/Sending_Emails_To_Customers for a ${MAGENTA}feature branch${RESTORE}"
echo "${RED}hotfix${RESTORE}/Fix_Production_Bug for a ${RED}hotfix${RESTORE}"
echo "[...] and so on, refer to ${CYAN}Semantic Flow${RESTORE} for a complete description of the workflow"
echo
echo -e "${GREEN}Happy committing !${RESTORE}"