#!/bin/bash
# This was just a training on blockchains concept, It does not have a pratical usage at the moment.
# The main idea is to have a folder with a group of files where no new file should be added or removed from
# source to destination. The block chain grant the integrity of all the files and the quantity of files in the group.
# Because of the circustances I created it on a Mac OS X system.
# To adapt to Linux (My default SO) change the place variable and md5 to md5sum command and the structure of the home folder.
# Mauricio @ 2018

place=/Users/mauricio/Movies
quant=$(find ${place} -type f | wc -l)
a=1
find ${place} -type f >> /tmp/blockchain
previous=Genesis

while [ ${a} != ${quant} ]
do hash=$(md5 -q "$(cat /tmp/blockchain | sed -n ${a}p)")
data=$(echo "$(cat /tmp/blockchain | sed -n ${a}p)")
echo "Doing hash for Block ${a}"
echo "Block = ${a}" >> block.log
echo "Hash = ${hash}" >> block.log
echo "Data = ${data}" >> block.log
echo "Previous = ${previous}" >> block.log
echo -e "\n" >> block.log
let a=$(($a + 1))
previous=$(echo ${hash})
done

echo "Done"
