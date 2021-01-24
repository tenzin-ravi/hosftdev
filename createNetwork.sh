docker network create \
  --driver=bridge \
  --subnet=172.20.0.0/16 \
  --ip-range=172.20.0.0/16 \
  --gateway=172.20.1.1 \
  hsoftdev	

