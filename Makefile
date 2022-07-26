.PHONY: *

gogo: stop-services build truncate-logs start-services

build:
	cd go && make isuports

stop-services:
	sudo systemctl stop nginx
	sudo systemctl stop isuports.service
	 ssh isucon12-02 "sudo systemctl stop mysql"

start-services:
	ssh isucon12-02 "sudo systemctl start mysql"
	sleep 5
	sudo systemctl start isuports.service
	sudo systemctl start nginx

truncate-logs:
	sudo truncate --size 0 /var/log/nginx/access.log
	sudo truncate --size 0 /var/log/nginx/error.log
	ssh isucon12-02 "sudo truncate --size 0 /var/log/mysql/mysql-slow.log"
	ssh isucon12-02 "sudo chmod 777 /var/log/mysql/mysql-slow.log"
	sudo journalctl --vacuum-size=1K
bench:
	cd ~/bench/ && ./bench

kataribe:
	sudo cat /var/log/nginx/access.log | ./kataribe -conf kataribe.toml
