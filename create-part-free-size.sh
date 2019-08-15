#/bin/bash

devname=$1


start=$(( $(parted $devname 'unit % print' | grep -v extended | tail -2 | grep . | awk '{print $3}' | tr -d %| cut -f1 -d".") + 1 ))

parted $devname mkpart ext2 "$start"% 100%
