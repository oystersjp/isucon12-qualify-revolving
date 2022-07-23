.PHONY: *

gogo: stop-services truncate-logs start-services kataribe

stop-services:
	sudo systemctl stop nginx
	sudo systemctl stop isuports.service
	sudo systemctl stop mysql

start-services:
	sudo systemctl start mysql
	sleep 5
	sudo systemctl start isuports.service
	sudo systemctl start nginx

truncate-logs:
	sudo truncate --size 0 /var/log/nginx/access.log
	sudo truncate --size 0 /var/log/nginx/error.log
	sudo truncate --size 0 /var/log/mysql/mysql-slow.log
	sudo chmod 777 /var/log/mysql/mysql-slow.log
	sudo journalctl --vacuum-size=1K

kataribe:
	sudo cat /var/log/nginx/access.log | ./kataribe -conf kataribe.toml
