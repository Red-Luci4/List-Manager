#! /usr/bin/bash


# Var to set File Extention as list

file_extention=list




# Functions to minuplate file ====================

check_existing_package() {
	grep -Eq "^$1$"< $2
	return $?
}


display_help(){

	echo -e "\nThis is a basic program to manage simple list\n\n"

	echo -e "This are the Options:\n"

	echo -e "  -h   Help\t:\tThis will display this menu\n"

	echo -e "  -r   Remove\t:\tThis will remove  item from list\n"

}


append_package_name() {
    echo "$1" >> "$2"
    echo "Item added successfully."
}

# ========================



if [[ $# -eq 0 ]]; then	# Checking for atleast 1 input
	echo -e "Input Required\n"
	echo -e "Check out the Help Doc:\n"
	display_help
	exit 3


elif [[ $1 = "-h" ]];then
	display_help
	exit 0


elif [[ $# -gt 3 ]];then # Checking if more than 3 arguments
	echo "Too many arguments"
	echo "Please only add package list and list location only"
	exit 1


elif [[ $2 = '' ]];then	# Checking for the 2nd input
	echo "Target File not given"
	exit 1


elif [[ $(echo "$2" | sed -E 's/.*(\..*)$/\1/') = ".$file_extention" ]]&&[[ -f "$2" ]]; then # Checking if 2nd is file with (dot)list
	echo "can append $1 to $2 since it is a List file"
	# exit 0

else
	echo "cant append $1 to $2 since it is not a List file"
	exit $3

fi

if [[ $# -eq 2 ]]; then
	check_existing_package "$1" "$2"

	if [[ $? != 0 ]]; then
		append_package_name "$1" "$2"

	else
		echo "Iten already in the List"

	fi


elif [[ $# -eq 3 ]];then

	if [[ $3 != "-r" ]];then
		echo "$3 is an unknown option, Please see the Help Document:"
		echo ""
		display_help

	else
		LIST="$(cat $2 |grep -P -v "^($1)$")"
		echo -e "$LIST" > "$2"

	fi

fi

exit 0

case 