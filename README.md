# Marshall Packaging System (MPS)

A tailored ruby on rails app for one of my customers.

## Build 

This application is composed of different micro-services controlled through docker containers. 

### Database

Please, type the following commands to create a data volume for persisting data into a db and afterward built the postgres image

```
docker run -d --name postgres_container -p 5432:5432 -e POSTGRES_USER=rails_user -e POSTGRES_PASSWORD=secret_password  -e POSTGRES_DB=devel -v pgvol:/var/lib/postgresql/data postgres:9.5.5
docker volume create --name pgvol
```

### Application

Please, type the following command to build a docker image with ruby, rails and any gem dependencies specified on src/Gemfile.

```
docker build -t ubuntu-rails .
```

## Run

It is crucial to follows the next steps as you reading them. 

### Database

```
docker run -d --name postgres_container -p 5432:5432 -e POSTGRES_PASSWORD=secret_password -e POSTGRES_USER=rails_user -e POSTGRES_DB=devel -v pgvol:/var/lib/postgresql/data postgres:9.5.5
```

Note, the first time you run the above mentioned command, you will need to ensure that POSGRES_USER has privileges to read/write on POSTGRES_DB. Please, visit the [link](https://www.postgresql.org/docs/9.5/static/sql-grant.html) for defining access privileges.

### Application

```
docker run --name rails_container -it --rm -p 3000:3000 -v "$PWD/src":/usr/src/app --link postgres_container:db ubuntu-rails:latest
```
