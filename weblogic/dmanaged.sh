docker container rm -f hsoftdevmanaged
docker run -dt --restart unless-stopped --network=hsoftdev --name hsoftdevmanaged --ip 10.250.2.11 --user oracle -e TZ=America/Los_Angeles \
          -v /opt/hsoftdev/weblogic/properties/docker-run:/u01/oracle/properties \
	  -v /opt/hsoftdev/weblogic/logs/DEV1.log:/u01/oracle/user_projects/domains/hsoftdev/servers/DEV1/logs/DEV1.log \
          -e MANAGED_SERV_NAME=DEV1 weblogic/hsoftdev startManagedServer.sh
