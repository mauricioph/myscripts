#!/bin/bash
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
