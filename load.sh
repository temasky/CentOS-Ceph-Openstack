#!/bin/bash

case $1 in
        -n)
                k=$2
        ;;
        start)
                for i in $(seq 1 `nproc`); do sha1sum /dev/zero &2>1; done
                exit 0
                ;;
        stop)
                pkill -f sha1sum
                exit 0
                ;;
        *)
                echo wrong paremeters, exit...
                exit 1
esac

case $3 in
        start)
                for i in $(seq 1 $k); do sha1sum /dev/zero &2>1; done
                ;;
        stop)
                pkill -f sha1sum
                ;;
        *)
                echo wrong paremeters, exit...
                exit 1
esac
