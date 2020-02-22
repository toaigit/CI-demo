#!/bin/bash
#  This is a simple shell script simulate your monthly job with CPU/Memory requirment.
#  You can modify this script to do whatever you want.

cd /tmp
total=0
while  read num 
do
  total=$((total+$num))
done < /tmp/add.txt
echo $total  > /tmp/total.txt

# this script just read the file /tmp/add.txt (which has a number on each line),
# add all up and write the result out to /tmp/total.txt
