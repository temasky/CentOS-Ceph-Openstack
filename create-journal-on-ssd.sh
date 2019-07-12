#!/bin/bash

devname=$1
extended_exist=$(parted $devname print | grep extended)
logical_exist=$(parted $devname print | grep -v Sector | grep logical)

size=$2

echo "extended value is :$extended_exist-"
echo "logical value is:$logical_exist-"

if [ -z "$extended_exist" ]
then
echo "extended no exist, creating.."

free=$(parted $devname 'unit s print' | grep -v extended | tail -2 | grep . | awk '{print $3}' | tr -d s)
free=$(( $free+1 ))

parted $devname mkpart extended "$free"s 100%

echo "logical no exist, creating.."

for i in {1..4}; do
        free=$(parted $devname 'unit % print' | grep -v extended | tail -2 | grep . | awk '{print $3}' | tr -d %| cut -f1 -d".")
        free=$(( $free+1 ))
        end=$(awk -v a="$free" -v b="$size" 'BEGIN {print a + b}')
        parted $devname mkpart  logical ext2 $(echo $free)% $(echo $end)%
done
elif [ -z "$logical_exist" ]
then
echo "extended exist, but logical no exist, creating.."
for i in {1..4}; do
        free=$(parted $devname 'unit % print' | grep -v extended | tail -2 | grep . | awk '{print $3}' | tr -d %| cut -f1 -d".")
        free=$(( $free+1 ))
        end=$(awk -v a="$free" -v b="$size" 'BEGIN {print a + b}')
        parted $devname mkpart  logical ext2 $(echo $free)% $(echo $end)%
done
fi
