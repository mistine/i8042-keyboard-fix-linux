#!/bin/sh
case $1/$2 in
    pre/*)
        rmmod i8042
        ;;
    post/*)
        modprobe i8042 reset=1
        ;;
esac
