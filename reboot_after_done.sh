#!/bin/sh -e

done=/home/yusuke/rebench_done
count=/home/yusuke/rebench_count

max_invocation=2

create_or_incr_file() {
    f=$1

    if [ ! -f $f ]; then
        echo 0 > $f
    else
        echo $(expr $(cat $f) + 1) > $f
    fi

}

do_command() {
    create_or_incr_file $count && sleep 0.1

    if [ ! -f $f ] || [ $(head -n 1 $count) -le $max_invocation ]; then
        echo "Do command..." && sleep 0.1
        cat $count > $done
        reboot
    else
        echo "Max invocation count exceeded." > $done && sleep 0.1
    fi
}

echo "Do something..." && sleep 0.1
do_command
