#/bin/bash

devname=$1

size=$2

partsize=$(( $size * 1024 * 1024 * 2 ))

start=$(( $(parted $devname 'unit % print' | grep -v extended | tail -2 | grep . | awk '{print $3}' | tr -d %| cut -f1 -d".") + 1 ))


for i in {1..4}; do

parted $devname mkpart ext2 "$(( $start + $(( $(( $i - 1 )) * 10 )) ))"% "$(( $start + $(( $i*10 )) ))"%

done
