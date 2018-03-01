#!/bin/bash

set -e
# Checks the connection status of PostgreSQL
until pg_isready -d $POSTGRES_DB -h db -U $POSTGRES_USER; do
 	sleep 1
done

exec "$@"