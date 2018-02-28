#!/bin/bash
#A script to update the repository

git status
options="[Add|Commit|Diff|Fetch|Exit|Help|Log|Push|User|Reset|Status]"
while echo -e -n "\n\n\033[36mPlease choose the first letter of options.\n$options? \033[0m "
	read -n1 choice
do
	echo -e "\n"
	case $choice in
	A | a)
		git add -A
		git status;;
	C | c)
		echo -e -n "\033[36mPlease enter the remark: \033[0m "
		read commit
		commitDate="[20"$(date +%y-%m-%d])
		commit=$commitDate$commit
		git commit -m "$commit";;
	D | d)
		git diff HEAD -- *;;
	E | e)
		exit 0;;
	F | f)
		git fetch origin master:origin_master
		git diff origin_master
		echo -e -n "\033[36mAre you sure to merge with origin_master[Y/N] \033[0m "
		read -n1 merge_choice
		echo -e "\n"
		if [[ $merge_choice == 'y' ]] || [[ $merge_choice == 'Y' ]]; then
			git merge origin_master
		else
			echo -e -n "\033[36mHaved canceled the merge option.\n \033[0m "
		fi
		git branch -D origin_master;;
	H | h)
		echo "	A: Add all changes to repository. "
		echo "	C: Commit all changes to repository. "
		echo "	D: Show differences between current version with HEAD->. "
		echo "	E: Exit shell script. "
		echo "	F: Fetch origin/master and merge. "
		echo "	L: Show latest two-weeks logs of repository. "
		echo "	P: Push commissions to origin/master. "
		echo "	U: User command mode(Press ‘Enter’ to exit). "
		echo "	R: Reset current version according version_id. "
		echo "	S: Show status of repository. ";;
	L | l)
		echo -e -n "\033[36mIt only shows the logs for nearly two weeks. \033[0m "
		git log --since=2.weeks --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset' --abbrev-commit;;
	P | p)
	        git push origin master
			git status;;
	U | u)
		echo -e "\033[36mPlease input user's instructions. \033[0m "
		while read -p ">> " myCmd
		do
			echo $myCmd
			if [[ $myCmd != '' ]]; then
				$myCmd
			else
				break
			fi
		done;;
	R | r)
		git log --since=2.weeks --color --graph --pretty=oneline
		echo -e -n "\033[36mPlease enter the reset_id: \033[0m "
		read reset_id
		git reset --hard $reset_id;;
	S | s)
		git status;;
	*)
		echo
		echo -e -n "\033[31m	Error input.\033[0m"
		echo;;
	esac
done