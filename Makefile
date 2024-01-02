install:
	cp reboot_after_done.sh /etc/rc.local

clean:
	$(RM) rebench_count rebench_done
