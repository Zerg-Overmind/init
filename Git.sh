#!/bin/bash
#A script to update the repository

git status
options=[Add/Commit/Diff/Exit/Log/Push/User/Reset/Status]
while echo -e -n "\n\nPlease choose the first letter of options.\n$options? "
	read -n1 choice
do
	echo -e "\n"
	case $choice in
	A | a)
		git add -A
		git status;;
	C | c)
		echo -e -n "Please enter the remark: "
		read commit
		commitDate="[20"$(date +%y-%m-%d])
		commit=$commitDate$commit
		echo $commit
		git commit -m "$commit";;
	D | d)
		git diff HEAD -- *;;
	E | e)
		exit 0;;
	L | l)
		echo "It only shows the logs for nearly two weeks."
		git log --since=2.weeks --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset' --abbrev-commit;;
	P | p)
	        git push origin master;;
	U | u)
		echo "Please input user's instructions."
		echo -e -n ">> "
		read myCmd
		$myCmd;;
	R | r)
		git log --since=2.weeks --color --graph --pretty=oneline
		read -p "Please enter the reset_id: " reset_id
		git reset --hard $reset_id;;
	S | s)
		git status;;
	*)
		echo
		echo "Error input"
		echo;;
	esac
done


