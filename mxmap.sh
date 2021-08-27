#!/usr/bin/env bash
count=0
if [[ "$1" =~ ^[a-zA-Z0-9.]*[a-zA-Z0-9]{0,62}$ ]];then
	for line in $(dig -t mx +short $1)
	do
		if ((count%2));then
			servers[$((count/2+1))]=${line%.*}
		fi
		count=$((count+1))
	done
	echo "Query to the post office server domain name:  ${servers[*]}"
	nmap ${servers[*]} ${*:2:$#}
elif [[ "$1" =~ ^(|-(h|-help))$ ]];then
	echo "Usage:  mxmap domain [Options]"
	echo "Where:  domain	  is in the Domain Name System"
	echo "Use \"nmap --help\" for complete list of options"
else
	echo "Error: Illegal parameters!"
fi
