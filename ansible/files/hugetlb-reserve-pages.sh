#!/bin/sh

nodes_path=/sys/devices/system/node/
if [ ! -d $nodes_path ]; then
        echo "ERROR: $nodes_path does not exist"
        exit 1
fi

reserve_pages()
{
        echo $1 > $nodes_path/$2/hugepages/hugepages-2048kB/nr_hugepages
}


nodes=$(ls /sys/devices/system/node/ | grep node)


for i in $nodes; do
  if [[ $i == node0 ]]
  then
       reserve_pages 512 $i
  else
       reserve_pages 0 $i
  fi
done
