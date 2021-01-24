docker container rm -f hsoftdev
docker run -it --network=oracledb --name hsoftdev --hostname hsoftdev -p 192.168.1.45:7001:7001 --ip 172.19.5.11  --user oracle -e TZ=America/Los_Angeles \
          -v /opt/hsoftdev/weblogic/properties/docker-run:/u01/oracle/properties \
          weblogic/hsoftdev
