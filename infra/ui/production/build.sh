#!/bin/bash
image_name=mps_production/ui

docker build -t $image_name -f infra/ui/production/Dockerfile ./

container_id=$(docker run -dit $image_name)

rm -r ./infra/apache/production/htdocs 2> /dev/null

docker cp ${container_id}:/usr/src/app/build ./infra/apache/production

mv ./infra/apache/production/build ./infra/apache/production/htdocs

docker stop ${container_id} && docker rm ${container_id}
