#!/usr/bin/env bash
count=0 
if [[ "${@: -1}" =~ ^([a-zA-Z0-9.]*\.)?[a-zA-Z0-9]{1,62}$ ]];then
	for line in $(dig -t mx +short ${@: -1})
	do
		if ((count%2));then
			servers[$((count/2+1))]=${line%.*}
		fi
		count=$((count+1))
	done
	echo "Query to the post office server domain name:  ${servers[*]}"
	if [[ "${*:1:$#-1}" != "--noscan" ]];then
		nmap ${servers[*]} ${*:1:$#-1}
	fi
elif [[ "$1" =~ ^(|-(h|-help))$ ]];then
	echo "Usage:  mxmap [Options] domain"
	echo "Where:  domain	  is in the Domain Name System"
	echo "Options:"
	echo "	--noscan	No scanning of post office servers"
	echo "Use \"nmap --help\" for a more extensive list of options"
else
	echo "Error: Illegal parameters!"
	exit 1
fi
