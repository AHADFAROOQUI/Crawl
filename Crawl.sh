#!/bin/bash

field="1"
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
            echo "$grep1" >> ./links.txt
        fi
        field=$((field+1))
    done
    clear
    pagecount=$((pagecount+1))
    echo "You have crawled $pagecount page(s)"
    echo "Check your links.txt file to access extracted URLs"
    echo "CTRL+C to kill the program"
    sleep 3
    else
        echo "Invalid Link"
        exit
    fi
done < ./links.txt