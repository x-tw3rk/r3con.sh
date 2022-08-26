#!/bin/bash

> results # Initialising files
> resultsGo
> resultsWeb

mkdir -p AutoReconResults

if [ -z "$1" ]
then
        echo "Usage: ./r3con.sh <IP>"
        exit 1
fi

printf "\nRUNNING THE MAGIC!!!\n\n" | lolcat
printf "++ ST4RT1NG NMAP ++" | lolcat
printf "\n"
printf "\n##### NM4P #####\n\n" | lolcat

nmap -sV $1 | tail -n +5 | head -n -3 >> results
cat results

while read line
do
        if [[ $line == *open* ]] && [[ $line == *http* ]]
                then
                        printf "\n++ ST4RT1NG G0BU5T3R3R ++" | lolcat
                        printf "\n"
                        gobuster dir -u $1 -w /usr/share/wordlists/dirb/common.txt -qz > temp1

                        if [ -e temp1 ]
                        then
                                printf "\n##### D1RS #####\n\n" | lolcat 
                                >> resultsGo
                                cat temp1 >> resultsGo
                                rm temp1
                                cat resultsGo
                        fi

                        printf "\n++ ST4RT1NG WH4T-W3B ++" |lolcat
                        printf "\n"
                        whatweb $1 -v > temp2

                        if [ -e temp2 ]
                        then
                                printf "\n##### W3B #####\n\n" | lolcat 
                                >> resultsWeb
                                cat temp2 >> resultsWeb
                                rm temp2
                                cat resultsWeb
                        fi

                fi
        
done < results

mv results ./AutoReconResults/
mv resultsGo ./AutoReconResults/
mv resultsWeb ./AutoReconResults/
