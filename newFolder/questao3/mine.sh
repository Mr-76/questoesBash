#!/bin/bash


#grab all lines matching starting with < inside anithing but > since thats the ending one and then that finishes with > then replace everty < and > by spaces :>
grep -o '<[^>]*>' ls.log | sed 's/[<>]//g' > times.txt
#Greab all lines that have a starting (  then replace any thing that starts with ( to the end .* means that and store all in a file
grep -o '.*(' ls.log  | sed 's/(.*//g' > systcalls.txt
#past side by side each line
paste systcalls.txt times.txt > final.txt
#delete last line since its a exit saying
sed -i '$ d' final.txt
#sorting in descending order based on the numerical 2nd field and storing the first bigger 3
sort -k2rn final.txt| head -n 3 > sorted.txt

echo -e "Most times\n$(head -n 3 sorted.txt)"

#Match lines that start with = and 2 other values in this case the numbers then delete the =
grep -o '= ..' ls.log  | sed 's/=//' > rates.txt
#merge tchugueda the names and the rates in on file
paste systcalls.txt rates.txt > finalSuc.txt

# finaly mach all calls with -1 and sort it
cat finalSuc.txt | grep -- "-1" > failedones.txt

#Count the numbers of repetions of each one -1 :)
#It does so using awk associative array, like a dict in pyhton, the array a 
#is used and each first field of the line so r -1 b -1 b -1 r is key and also b 
#later by looping it coutns plus 1 to r and 2 to b and then sorts it in descending order
awk '{a[$1]++}END{for(i in a)print i,a[i]}' failedones.txt | sort -k2nr > failedfinal.txt

echo -e "Most errors\n$(head -n 1 failedfinal.txt)"

Erros=$(awk '{sum += $2} END {print sum}' failedfinal.txt)

echo "Number of erros $Erros"

rm *.txt






