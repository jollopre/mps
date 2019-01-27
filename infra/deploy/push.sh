#!/bin/bash

CWD=$([[ ${0:0:1} = "/" ]] && echo $(dirname $0) || echo $PWD/$(dirname $0))
image_name=mps/rsync
dest_path="~/deploy"

source $CWD/../credentials/deploy.env

docker build -t $image_name -f $CWD/Dockerfile .

docker run --rm -it \
  -v "$CWD/../../:/root/mps" \
  $image_name rsync \
  --verbose \
  --archive \
  --compress \
  --progress \
  --stats \
  --rsync-path="mkdir -p $dest_path && rsync" \
  --exclude=".*" \
  --exclude="api/log" \
  --exclude="api/tmp" \
  --exclude="infra/credentials/ubuntu.pem" \
  --exclude="infra/credentials/*.gpg" \
  --exclude="infra/*/test" \
  --exclude="infra/*/development" \
  --exclude="infra/apache/production/htdocs/*" \
  --exclude="ui/build" \
  --exclude="ui/node_modules" \
  --exclude="ui/coverage" \
  -e "ssh -i ./mps/infra/credentials/ubuntu.pem" \
  ./mps ubuntu@$PUBLIC_IP:$dest_path
