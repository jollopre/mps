# Marshall Packaging System (MPS)

A tailored ruby on rails app.

## Build docker images

This application is composed of different micro-services controlled through docker containers. 

### Database

Type below commands to create a data volume for persisting data into a db and afterwards built the postgres image:

```
docker pull postgres:9.5.5
docker volume create --name mps_devel
```

### Application

Type the following command to build a docker image with ruby and all the gem dependencies needed for this code:

```
docker build -t ubuntu-rails .
```

## Run docker containers

Use the script provided within this repository (e.g. docker.sh) to run the containers:

```
bash docker.sh run
```

## Stop/remove docker containers

Use the script provided within this repository (e.g. docker.sh) to stop and remove the containers:

```
bash docker.sh stop-remove
```

## Running every test
```
rails test -e test
```