#! /bin/bash
#
# Bash script to orchestrate a development/testing environment using docker containers.

# If first character is / then absolute path, otherwise relative path
CWD=$([[ ${0:0:1} = "/" ]] && echo $(dirname $0) || echo $PWD/$(dirname $0))

function build () {
	docker build -t $MPS_WEB_IMAGE_NAME $CWD/.
	docker pull $MPS_DB_IMAGE_NAME
	create_volume $MPS_DB_VOLUME
	create_volume $MPS_DB_VOLUME_TEST
	create_network
}

function create_volume () {
	local volume_name=$1
	local result

	result=$(docker volume ls | grep $volume_name)
	if [ -z "$result" ]; then
		docker volume create --name $volume_name
		if [ $? -eq 0 ]; then
			echo "Volume $volume_name created"
		fi
	else
		echo "Volume $volume_name already exists, will not be created again"
	fi
}

function create_network () {
	local exit_status
	local result

	result=$(docker network ls | grep $MPS_NET_NAME)
	if [ -z "$result" ]; then 
		docker network create \
			--driver bridge \
			--subnet $MPS_NET_SUBNET \
			--gateway $MPS_NET_GATEWAY \
			$MPS_NET_NAME
		exit_status=$?
		if [ $exit_status -eq 0 ]; then
			echo "Network $MPS_NET_NAME created"
		fi
		return $exit_status
	else
		echo "Network $MPS_NET_NAME already exists, will not be created again"
		return 1
	fi
}

function run () {
	local exit_status

	docker run \
		--detach \
		--name $MPS_DB_CONTAINER_NAME \
		--publish $MPS_DB_PORT:5432 \
		--network $MPS_NET_NAME \
		--ip $MPS_DB_IP \
		--env POSTGRES_USER=$MPS_DB_USER \
		--env POSTGRES_PASSWORD=$MPS_DB_PASSWORD \
		--env POSTGRES_DB=$MPS_DB_NAME \
		--volume $MPS_DB_VOLUME:/var/lib/postgresql/data \
		$MPS_DB_IMAGE_NAME && \
	docker run \
		--detach \
		--name $MPS_DB_TEST_CONTAINER_NAME \
		--publish $MPS_DB_TEST_PORT:5432 \
		--network $MPS_NET_NAME \
		--ip $MPS_DB_TEST_IP \
		--env POSTGRES_USER=$MPS_DB_USER \
		--env POSTGRES_PASSWORD=$MPS_DB_PASSWORD \
		--env POSTGRES_DB=$MPS_DB_NAME \
		--volume $MPS_DB_VOLUME_TEST:/var/lib/postgresql/data \
		$MPS_DB_IMAGE_NAME

	exit_status=$?

	if [ $exit_status -eq 0 ]; then
		docker run \
			--detach \
			--name $MPS_WEB_CONTAINER_NAME \
			--publish $MPS_WEB_PORT:3000 \
			--network $MPS_NET_NAME \
			--ip $MPS_WEB_IP \
			--volume "$CWD/server":/usr/src/app \
			--env-file "$CWD/env.sh" \
			$MPS_WEB_IMAGE_NAME
		exit_status=$?
	fi
	return $exit_status
}

function stop_remove () {
	local exit_status

	docker stop $MPS_WEB_CONTAINER_NAME && \
	docker stop $MPS_DB_CONTAINER_NAME && \
	docker stop $MPS_DB_TEST_CONTAINER_NAME
	exit_status=$?

	if [ $exit_status -eq 0 ]; then
		docker rm $MPS_WEB_CONTAINER_NAME && \
		docker rm $MPS_DB_CONTAINER_NAME && \
		docker rm $MPS_DB_TEST_CONTAINER_NAME
		exit_status=$?
	fi
	return $exit_status
}

function main () {
	source $CWD/env.sh

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