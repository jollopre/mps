#!/bin/bash

set -e

until pg_isready -d $POSTGRES_DB -h $POSTGRES_HOST -U $POSTGRES_USER; do
  sleep 1
done

version=$(rails db:version | awk '{ print $3 }')
echo $version

if [ $version -eq 0 ]; then
  bundle exec rails db:setup
fi

exec "$@"
