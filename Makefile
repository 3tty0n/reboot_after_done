all: clean install

install:
	cp reboot_after_done.sh /etc/rc.local
	chown root /etc/rc.local
	chmod 755 /etc/rc.local

clean:
	$(RM) /etc/rc.local
	$(RM) rebench_count rebench_done
