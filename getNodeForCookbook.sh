#!/bin/bash
#
# Author : Govindarajan V
# This tells you the node to look for given the search string
#
if [ $1"l" = "l" ]
then
  echo "Search term cannot be null"
  exit 0
elif [ $1"l" = "--helpl" -o $1"l" = "-hl" ]
then
  echo "getNodeForCookbook <chef environment name> <search string>"
  exit 0
elif [ $# -gt 2 -o $# -eq 1 ]
then
  echo "Invalid options"
  exit 0
fi

for i in `knife node list -E $1`
do
  knife node show $i |grep $2 && printf "\n\n\n"  && echo "Suggested node is $i" && printf  "\n\n"
done

