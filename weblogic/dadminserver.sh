docker container rm -f hsoftdev
docker run -dt --network=oracledb --restart unless-stopped --name hsoftdev --hostname hsoftdev -p 192.168.1.45:7040:7001 --ip 172.19.5.11  --user oracle -e TZ=America/Los_Angeles \
          -v /opt/hsoftdev/weblogic/properties/docker-run:/u01/oracle/properties \
	  -v /opt/hsoftdev/weblogic/Reports/CAPES/:/u01/oracle/Reports/CAPES/ \
	  -v /opt/hsoftdev/weblogic/logs/capes.log:/u01/oracle/Projects/CAPES_config/capes.log \
	  -v  /opt/hsoftdev/weblogic/logs/debug.log:/u01/oracle/Projects/CAPES_config/debug.log \
          weblogic/hsoftdev
#-v  /opt/hsoftdev/weblogic/logs/hsoftadmin.log:/u01/oracle/user_projects/domains/hsoftdev/servers/hsoftadmin/logs/hsoftadmin.log \
