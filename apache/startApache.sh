docker container rm -f hsoftdevapache
access_log_src=/opt/hsoftdev/apache/logs/access_log; \
access_log_dst=/etc/httpd/logs/access_log; \
error_log_src=/opt/hsoftdev/apache/logs/error_log; \
error_log_dst=/etc/httpd/logs/error_log; \
ssl_log_src=/opt/hsoftdev/apache/logs/ssl_access_log; \
ssl_log_dst=/etc/httpd/logs/ssl_access_log; \	
ssl_error_log_src=/opt/hsoftdev/apache/logs/ssl_error_log; \
ssl_error_log_dst=/etc/httpd/logs/ssl_error_log; \	
docker run --network=oracledb -dt --restart unless-stopped -p 192.168.1.45:443:443 -p 192.168.1.45:80:80 --ip 172.19.5.12 \
--name hsoftdevapache \
--mount type=bind,src=${access_log_src},dst=${access_log_dst} \
--mount type=bind,src=${error_log_src},dst=${error_log_dst} \
--mount type=bind,src=${ssl_log_src},dst=${ssl_log_dst} \
--mount type=bind,src=${ssl_error_log_src},dst=${ssl_error_log_dst} \
apache/hsoftdev
#docker network connect hsoftdev capesapache
