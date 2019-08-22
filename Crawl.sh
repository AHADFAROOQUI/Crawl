#!/bin/bash

#check to see if link is already in file
#check for / at the end of each URL and THEN add it to links.txt


pagecount="0"
#[ ! -d Crawl ] && mkdir Crawl
#cd ./Crawl
[ -f ./index.html ] && rm ./index.html
[ -f ./links.txt ] && rm ./links.txt
[ -f ./crawlme.txt ] && rm ./crawlme.txt
read -p "Enter starting URL: " URL
if [ ! -z $URL ]
then
    echo "$URL" > ./links.txt
else
    read -p "Please enter a URL.."
    exit
fi
while read links
do
    field="1"
    clear
    if wget -O index.html $links
    then
    sleep 3
    cat index.html | tr -d '\n' > ./crawlme.txt
    rm ./index.html
    while true
    do
        grep "href=" ./crawlme.txt | cut -d '"' -f $field
        grep1=$(grep "href=" ./crawlme.txt | cut -d '"' -f $field)
        if [ -z "$grep1" ]
        then
            field=$((field+1))
            grep "href=" ./crawlme.txt | cut -d '"' -f $field
            grep1=$(grep "href=" ./crawlme.txt | cut -d '"' -f $field)
            if [ -z "$grep1" ]
            then
                break
            fi
        fi
        if [ "${grep1:0:4}" == "http" ]
        then
	    if ! grep -Fxq $grep1 ./links.txt
	    then
                echo "$grep1" >> ./links.txt
	    fi
        fi
        field=$((field+1))
    done
    clear
    linkcount=$(wc -l links.txt | cut -d " " -f 1)
    pagecount=$((pagecount+1))
    echo "You have crawled $pagecount page(s)"
    echo "and you have extracted $linkcount link(s).."
    echo "Check your links.txt file to access extracted URLs"
    echo "CTRL+C to kill the program"
    sleep 3
    else
        line2=$(head -2 links.txt | tail -1)
	if [ -z $line2 ]
	then
	clear
        echo "The starting link you have provided is not valid.."
	echo "Please try a new URL."
	sleep 3
        exit
	fi
    fi
done < ./links.txt
