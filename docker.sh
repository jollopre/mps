#! /bin/bash

MPS_DB_IMAGE_NAME=postgres:9.5.5
MPS_WEB_IMAGE_NAME=ubuntu-rails:latest
MPS_DB_VOLUME=mps_devel

MPS_DB_CONTAINER_NAME=mps_db_container
MPS_WEB_CONTAINER_NAME=mps_web_container

MPS_DB_USER=mps_user
MPS_DB_PASSWORD=secret_password
MPS_DB_NAME=mps_devel
MPS_DB_PORT=5432

MPS_WEB_PORT=3000

# If first character is / then absolute path, otherwise relative path
CWD=$([[ ${0:0:1} = "/" ]] && echo $(dirname $0) || echo $PWD/$(dirname $0))

function build () {
	echo "TODO build"
}

function run () {
	local exit_status

	docker run \
		--detach \
		--name $MPS_DB_CONTAINER_NAME \
		--publish $MPS_DB_PORT:5432 \
		--env POSTGRES_USER=$MPS_DB_USER \
		--env POSTGRES_PASSWORD=$MPS_DB_PASSWORD \
		--env POSTGRES_DB=$MPS_DB_NAME \
		--volume $MPS_DB_VOLUME:/var/lib/postgresql/data \
		$MPS_DB_IMAGE_NAME
	exit_status=$?

	if [ $exit_status -eq 0 ]; then
		docker run \
			--detach \
			--name $MPS_WEB_CONTAINER_NAME \
			--publish $MPS_WEB_PORT:3000 \
			--volume "$CWD/src":/usr/src/app \
			--link $MPS_DB_CONTAINER_NAME:db \
			ubuntu-rails:latest
		exit_status=$?
	fi
	return $exit_status
}

function stop_remove () {
	local exit_status

	docker stop $MPS_WEB_CONTAINER_NAME && docker stop $MPS_DB_CONTAINER_NAME
	exit_status=$?

	if [ $exit_status -eq 0 ]; then
		docker rm $MPS_WEB_CONTAINER_NAME && docker rm $MPS_DB_CONTAINER_NAME
		exit_status=$?
	fi
	return $exit_status
}

function main () {
	if [ "$1" = "build" ]; then
		build
	elif [ "$1" = "run" ]; then
		run
	elif [ "$1" = "stop-remove" ]; then
		stop_remove
	else
		echo "Usage: $(basename $0) build | run | stop-remove"
		return 1
	fi
}

main "$@"