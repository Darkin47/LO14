#!/bin/bash

####################
#
#	COMMON PART
#	Description : check arguments syntax, config and finally execute the command.
#
####################

# Display vsh usage.
function display_usage {
	echo 'Usage : vsh [-start port (archives_directory)] [-stop port] [-list destination port] [-browse destination port archive_name] [-extract destination port archive_name]'
	exit 0
}

# Check syntax of the arguments.
# $1 - option
# $2 - IP/port
# $3 - port
# $4 - archive_name
function check_arguments {
	# check primary option
	if [[ $1 == '--help' || $1 == '-help' || $1 == '-h' ]]; then
		display_usage
		exit 0
	elif [[ $1 == '-start' && $# -ne 2 && $# -ne 3 ]]; then
		echo 'Invalid number of arguments.'
		display_usage
		exit 1
	elif [[ $1 == '-stop' && $# -ne 2 ]]; then
		echo 'Invalid number of arguments.'
		display_usage
		exit 1
	elif [[ $1 == '-list' && $# -ne 3 ]]; then
		echo 'Invalid number of arguments.'
		display_usage
		exit 1
	elif [[ ($1 == '-browse' || $1 == '-extract') && $# -ne 4 ]]; then
		echo 'Invalid number of arguments.'
		display_usage
		exit 1
	elif [[ $1 != '-start' && $1 != '-stop' && $1 != '-list' && $1 != '-browse' && $1 != '-extract' ]]; then
		echo 'Invalid option.'
		display_usage
		exit 1
	fi
	# check arguments syntax
	if [[ $1 == '-list' || $1 == '-browse' || $1 == '-extract' ]]; then
		check_ip "$2"
		check_port "$3"
		ping_server "$2" "$3"
	else
		check_port "$2"
	fi
	# check if a file is specified and if it is available on the server
	if [[ $1 == '-browse' || $1 == '-extract' ]]; then
		if [[ -z $4 ]]; then
			echo -e "You should specify the archive name.\nType 'vsh -list $2 $3' to display archives present on the server."
			exit 1
		else
			find_archive "$2" "$3" "$4"
		fi
	fi
}

# Check if the parameter is a valid ip address
# $1 - IP address
function check_ip {
	if ! [[ $1 == 'localhost' ]]; then
		if [[ $(grep -o '\.' <<< "$1" | wc -l) -ne 3 ]]; then
	    		echo "Parameter '$1' does not look like an IP address."
	    		exit 1
		fi
		if [[ $(tr '.' ' ' <<< "$1" | wc -w) -ne 4 ]]; then
	    		echo "Parameter '$1' does not look like an IP address."
	    		exit 1
		fi
		local -i octet
		for octet in $(tr '.' ' ' <<< "$1"); do
	    		if ! [[ $octet =~ ^[0-9]+$ ]]; then
				echo "Parameter '$1' does not look like an IP address."
				exit 1
	    		fi
		done
		for octet in $(tr '.' ' ' <<< "$1"); do
	    		if [[ $octet -lt 0 || $octet -gt 255 ]]; then
				echo "Parameter '$1' does not look like an IP address (octet '$octet' is not in range 0-255)."
				exit 1
	    		fi
		done
	fi
}

# Check if the parameter is a valid port number
# $1 - port number
function check_port {
	if ! [[ $1 =~ ^[0-9]+$ ]]; then
		echo "Parameter '$1' does not look like a port."
		exit 1
	fi
}

# Check if the specified server is online and get the welcome message.
function ping_server {
	local ping=$(send_msg 'ping')
	if [[ -z $ping ]]; then
		echo "Could not access to the server $1:$2"
		exit 1
	else
		echo -e -n "$ping\n";
	fi
}

# Check if the file is present on the specified server.
# $1 - IP address
# $2 - port
# $3 - archive name
function find_archive {
	local answer=$(send_msg "find_archive $3")
	if [[ $answer == false ]]; then
		echo -e "File '$3' is not present on the server.\nType 'vsh -list $1 $2' to display archives present on the server."
		exit 1
	fi
}

# Check if required packages are installed.
function check_config {
	local list='nmap nc.openbsd'
	local package
	local result
	for package in $list; do
		if [[ -z $(command -v "$package") ]]
		then
			result="$result$package\n"
		fi
	done
	if ! [[ -z $result ]]; then
		echo -e -n "vsh required these packages to be installed :\n$result"
		exit 1
	fi
}

# Execute the command.
# $1 - option
# $2 - port
function execute_command {
	if [[ $1 == '-start' ]]; then
		start_server "$2"
	elif [[ $1 == '-stop' ]]; then
		stop_server "$2"
	else
		case $1 in
			'-browse')
				browse_mode;;
			'-extract')
				extract_mode;;
			'-list')
				show_list;;
			*)
				echo 'Fatal error!'
				exit 1;;
		esac
	fi
}
