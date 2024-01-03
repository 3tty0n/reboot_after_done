#!/bin/sh -e

done=/home/yusuke/src/reboot_after_done/rebench_done
count=/home/yusuke/src/reboot_after_done/rebench_count

max_invocation=10

bm_path=/home/yusuke/src/PySOM

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

    if [ ! -f $f ] || [ $(head -n 1 $count) -lt $max_invocation ]; then
        echo "Do command..." && sleep 0.1
        cd $bm_path || exit 1
        ./rebench -in 1 -c runbench.conf
        cat $count > $done
        reboot
    else
        echo "Max invocation count exceeded."
        echo "Done." > $done && sleep 0.1
    fi
}

do_command

